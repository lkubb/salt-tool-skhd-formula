{%- from 'tool-skhd/map.jinja' import skhd -%}

include:
  - .package
  - .service
{%- if skhd.users | selectattr('dotconfig', 'defined') | selectattr('dotconfig') | list %}
  - .configsync
{%- endif %}
