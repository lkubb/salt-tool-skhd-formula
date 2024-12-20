# vim: ft=sls

{#-
    Removes the configuration of the skhd service and has a
    dependency on `tool_skhd.service.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_service_clean = tplroot ~ ".service.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as skhd with context %}

include:
  - {{ sls_service_clean }}


{%- for user in skhd.users %}

skhd config file is cleaned for user '{{ user.name }}':
  file.absent:
    - name: {{ user["_skhd"].conffile }}
    - require:
      - sls: {{ sls_service_clean }}

skhd config dir is absent for user '{{ user.name }}':
  file.absent:
    - name: {{ user["_skhd"].confdir }}
{%- endfor %}
