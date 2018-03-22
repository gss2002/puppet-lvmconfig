# Class: lvmconfig
#
# This module manages lvmconfig
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class lvmconfig {
    lvm_config { "":
      value  => "",
      config => "",
    }    
}
