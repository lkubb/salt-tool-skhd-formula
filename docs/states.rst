Available states
----------------

The following states are found in this formula:

.. contents::
   :local:


``tool_skhd``
~~~~~~~~~~~~~
*Meta-state*.

Performs all operations described in this formula according to the specified configuration.


``tool_skhd.package``
~~~~~~~~~~~~~~~~~~~~~
Installs the skhd package only.


``tool_skhd.config``
~~~~~~~~~~~~~~~~~~~~
Manages the skhd service configuration by

* recursively syncing from a dotfiles repo

Has a dependency on `tool_skhd.package`_.


``tool_skhd.service``
~~~~~~~~~~~~~~~~~~~~~
Starts the skhd service and enables it at boot time.
Has a dependency on `tool_skhd.config`_.


``tool_skhd.clean``
~~~~~~~~~~~~~~~~~~~
*Meta-state*.

Undoes everything performed in the ``tool_skhd`` meta-state
in reverse order.


``tool_skhd.package.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Removes the skhd package.
Has a dependency on `tool_skhd.config.clean`_.


``tool_skhd.config.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~
Removes the configuration of the skhd service and has a
dependency on `tool_skhd.service.clean`_.


``tool_skhd.service.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Stops the skhd service and disables it at boot time.


