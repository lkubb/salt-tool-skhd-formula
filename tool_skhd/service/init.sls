# vim: ft=sls

{#-
    Starts the skhd service and enables it at boot time.
    Has a dependency on `tool_skhd.config`_.
#}

include:
  - .running
