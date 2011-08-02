#
# Cookbook Name:: php
# Recipe:: default
#
#

package "xdebug"

template "/usr/local/etc/php5/conf.d/xdebug.ini" do
  source "mods/xdebug.ini.erb"
end
