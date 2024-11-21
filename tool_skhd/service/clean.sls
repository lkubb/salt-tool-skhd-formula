# vim: ft=sls

{#-
    Stops the skhd service and disables it at boot time.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as skhd with context %}


{%- for user in skhd.users | rejectattr("skhd.autostart", "false") %}
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
