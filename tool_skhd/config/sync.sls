# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as skhd with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch %}

skhd is restarted:
  cmd.wait:  # noqa: 213
    - name: brew services restart skhd
    - runas: {{ skhd.lookup.brew_user }}

{%- for user in skhd.users | selectattr('dotconfig', 'defined') | selectattr('dotconfig') %}
{%-   set dotconfig = user.dotconfig if dotconfig is mapping else {} %}

skhd configuration is synced for user '{{ user.name }}':
  file.recurse:
    - name: {{ user['_skhd'].confdir }}
    - source: {{ files_switch(
                ['skhd'],
                default_files_switch=['id', 'os_family'],
                override_root='dotconfig',
                opt_prefixes=[user.name]) }}
    - context:
        user: {{ user | json }}
    - template: jinja
    - user: {{ user.name }}
    - group: {{ user.group }}
{%-   if dotconfig.get('file_mode') %}
    - file_mode: '{{ dotconfig.file_mode }}'
{%-   endif %}
    - dir_mode: '{{ dotconfig.get('dir_mode', '0700') }}'
    - clean: {{ dotconfig.get('clean', False) | to_bool }}
    - makedirs: true
    - watch_in:
      - skhd is restarted
{%- endfor %}
