# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as skhd with context %}


skhd service is dead:
  service.running:
    - name: brew services stop {{ skhd.lookup.service.name }}
    - runas: {{ skhd.lookup.brew_user }}
    - onlyif:
      - sudo -u {{ skhd.lookup.brew_user }} brew services list | grep -e '^skhd' | grep started
