# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as skhd with context %}

include:
  - {{ sls_package_install }}

skhd service is running:
  service.running:
    - name: brew services start {{ skhd.lookup.service.name }}
    - runas: {{ skhd.lookup.brew_user }}
    - unless:
      - sudo -u {{ skhd.lookup.brew_user }} brew services list | grep -e '^skhd' | grep started
    - require:
      - skhd is installed
