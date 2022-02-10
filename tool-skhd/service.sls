{%- from 'tool-skhd/map.jinja' import skhd -%}

include:
  - .package

skhd service is running:
  cmd.run:
    - name: brew services start skhd
    - runas: {{ skhd._brew_user }}
    - unless:
      - sudo -u {{ skhd._brew_user }} brew services list | grep -e '^skhd' | grep started
    - require:
      - skhd is installed
