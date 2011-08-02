#
# Cookbook Name:: memcached
# Recipe:: default
#
#
include_recipe "memcached"

package "php-memcached"

template "/usr/local/etc/php5/conf.d/memcached.ini" do
  source "mods/memcached.ini.erb"
end
