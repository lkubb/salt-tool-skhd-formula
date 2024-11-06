# vim: ft=sls

{#-
    Removes the skhd package.
    Has a dependency on `tool_skhd.config.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_config_clean = tplroot ~ ".config.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as skhd with context %}

include:
  - {{ sls_config_clean }}


skhd is removed:
  pkg.removed:
    - name: {{ skhd.lookup.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
