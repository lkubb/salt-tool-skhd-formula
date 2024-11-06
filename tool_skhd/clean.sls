# vim: ft=sls

{#-
    *Meta-state*.

    Undoes everything performed in the ``tool_skhd`` meta-state
    in reverse order.
#}

include:
  - .service.clean
  - .config.clean
  - .package.clean
