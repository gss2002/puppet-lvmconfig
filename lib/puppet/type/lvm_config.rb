require 'puppet'
require 'puppet/parameter/boolean'

Puppet::Type.newtype(:lvm_config) do
  desc <<-EOS
    This type allows setting lvmconfig.
   
    Example usage:
  
      Update lvm.conf using lvmconfig
        
        lvm_config { '/etc/lvm/lvm.conf':
          config  => 'devices/filter',
          value  => '["a|sd.*|", "a|drbd.*|", "r|.*|"]',
        }

          
  EOS

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc "The name of lvmconfig object for puppet usage"
  end
  
  newparam(:config) do
    desc "lvmconfig config name to set in lvm.conf"
  end
  
  newparam(:value) do
    desc "lvmconfig config value to set in lvm.conf"
  end
 
  newparam(:default, :boolean => true, :parent => Puppet::Parameter::Boolean) do
    desc "When set to true lvm.conf is reverted to default"
    defaultto :false
  end  
  
end