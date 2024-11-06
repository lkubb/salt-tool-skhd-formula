# vim: ft=sls

{#-
    Manages the skhd service configuration by

    * recursively syncing from a dotfiles repo

    Has a dependency on `tool_skhd.package`_.
#}

include:
  - .sync
