#
# Cookbook Name:: php
# Recipe:: default
#
#

package "mongodb-php"

template "/usr/local/etc/php5/conf.d/mongo.ini" do
  source "mods/mongo.ini.erb"
end
