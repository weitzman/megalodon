#
# Cookbook Name:: php
# Recipe:: default
#

package "apc" do
  action :install
  options "--HEAD"
end

template "/usr/local/etc/php5/conf.d/apc.ini" do
  source "mods/apc.ini.erb"
end
