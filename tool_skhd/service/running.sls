# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_package_install = tplroot ~ ".package.install" %}
{%- from tplroot ~ "/map.jinja" import mapdata as skhd with context %}
{%- from tplroot ~ "/libtofsstack.jinja" import files_switch %}

include:
  - {{ sls_package_install }}


{%- for user in skhd.users | selectattr("skhd.autostart", "false") %}

{%-   if user.name == skhd.lookup.console_user %}

skhd service is not running:
  service.dead:
    - name: {{ skhd.lookup.service.name }}
    - require_in:
      - skhd service is ignored for user '{{ user.name }}'
{%-   endif %}

skhd service is ignored for user '{{ user.name }}':
  file.absent:
    - name: {{ user.home | path_join("Library", "LaunchAgents", skhd.lookup.service.name ~ ".plist") }}
{%- endfor %}

{%- for user in skhd.users | rejectattr("skhd.autostart", "false") %}

skhd service is loaded during login for user '{{ user.name }}':
  file.managed:
    - name: {{ user.home | path_join("Library", "LaunchAgents", skhd.lookup.service.name ~ ".plist") }}
    - source: {{ files_switch(
                    ["com.koekeishiya.skhd.plist", "com.koekeishiya.skhd.plist.j2"],
                    lookup="skhd service is loaded during login for user '{}'".format(user.name),
                    config=skhd,
                    custom_data={"users": [user.name]},
                 )
              }}
    - user: {{ user.name }}
    - group: {{ user.group }}
    - template: jinja
    - mode: '0644'
    - makedirs: true
    - require:
      - skhd is installed
{%-   if user.dotconfig %}
      - skhd configuration is synced for user '{{ user.name }}'
{%-   endif %}
    - context:
        skhd: {{ skhd | json }}
        user: {{ user | json }}

{%-   if user.name == skhd.lookup.console_user %}

skhd service is running:
  service.running:
    - name: {{ skhd.lookup.service.name }}
    - enable: true
    - require:
      - skhd service is loaded during login for user '{{ user.name }}'
{%-     if user.dotconfig %}
    - watch:
      - skhd configuration is synced for user '{{ user.name }}'
{%-     endif %}
{%-   endif %}
{%- endfor %}
