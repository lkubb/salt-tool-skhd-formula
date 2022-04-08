# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as skhd with context %}

skhd is installed:
  pkg.installed:
    - name: {{ skhd.lookup.pkg.name }}
    - version: {{ skhd.get('version') or 'latest' }}
    {#- do not specify alternative return value to be able to unset default version #}

skhd setup is completed:
  test.nop:
    - name: Hooray, skhd setup has finished.
    - require:
      - pkg: {{ skhd.lookup.pkg.name }}
