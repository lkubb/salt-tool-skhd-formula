{%- from 'tool-skhd/map.jinja' import skhd -%}

skhd is installed:
  pkg.installed:
    - name: koekeishiya/formulae/yabai

skhd setup is completed:
  test.nop:
    - name: Hooray, skhd setup has finished.
    - require:
      - pkg: koekeishiya/formulae/yabai
