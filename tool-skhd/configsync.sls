{%- from 'tool-skhd/map.jinja' import skhd -%}

skhd is restarted:
  cmd.wait:
    - name: brew services restart skhd
    - runas: {{ skhd._brew_user }}

{%- for user in skhd.users | selectattr('dotconfig', 'defined') | selectattr('dotconfig') | list %}
  {%- set dotconfig = user.dotconfig if dotconfig is mapping else {} %}

skhd configuration is synced for user '{{ user.name }}':
  file.recurse:
    - name: {{ user._skhd.confdir }}
    - source:
      - salt://dotconfig/{{ user.name }}/skhd
      - salt://dotconfig/skhd
    - context:
        user: {{ user | json }}
    - template: jinja
    - user: {{ user.name }}
    - group: {{ user.group }}
  {%- if dotconfig.get('file_mode') %}
    - file_mode: '{{ dotconfig.file_mode }}'
  {%- endif %}
    - dir_mode: '{{ dotconfig.get('dir_mode', '0700') }}'
    - clean: {{ dotconfig.get('clean', False) | to_bool }}
    - makedirs: True
    - watch_in:
      - skhd is restarted
{%- endfor %}
