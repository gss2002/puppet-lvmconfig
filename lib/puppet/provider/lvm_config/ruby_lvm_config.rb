# This type allows modification of lvmconfig of files via ruby
#
require 'puppet'
require 'fileutils'
require 'base64'


Puppet::Type.type(:lvm_config).provide(:ruby_lvm_config) do

  commands :lvmconfig => 'lvmconfig'

  def setlvmconfig
    config =  resource[:config]
    value = resource[:value]
     
    ret = %x[lvmconfig  --config #{config}=\'#{value}\' --merged -f /etc/lvm/lvm.conf]
    if $?.exitstatus == 0
     true
    else
     false  
    end 
  end

 def exists?
    value = resource[:value].gsub(/\s+/, "")
    valueb64 = Base64.encode64(value)
    ret = %x[lvmconfig '#{resource[:config]}']
    if $?.exitstatus == 0
      valueout = ret.split("=")[1].strip
      valueoutb64 = Base64.encode64(valueout)
      if valueb64.eql?valueoutb64
        true
      else
        false
      end
   else
     false   
  end
 end


  def destroy
    args = []
    args << ['--type', 'default', '-f', '/etc/lvm/lvm.conf']
    lvmconfig(args)
    true
  end

  def create
    succ = setlvmconfig()
    if !succ
      Puppet.crit("lvmconfig of '#{resource[:config]}' = '#{resource[:value]}' failed!")
    end
    succ
  end

end