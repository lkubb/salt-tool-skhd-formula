{%- from 'tool-skhd/map.jinja' import skhd -%}

skhd is restarted:
  cmd.wait:
    - name: brew services restart skhd
    - runas: {{ skhd._brew_user }}

{%- for user in skhd.users | selectattr('dotconfig', 'defined') | selectattr('dotconfig') | list %}

skhd configuration is synced for user '{{ user.name }}':
  file.recurse:
    - name: {{ user._skhd.confdir }}
    - source:
      - salt://dotconfig/{{ user.name }}/skhd
      - salt://dotconfig/skhd
    - context:
        user: {{ user }}
    - template: jinja
    - user: {{ user.name }}
    - group: {{ user.group }}
    - file_mode: keep
    - dir_mode: '0700'
    - makedirs: True
    - watch_in:
      - skhd is restarted
{%- endfor %}
