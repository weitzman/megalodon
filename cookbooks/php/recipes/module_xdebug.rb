#
# Cookbook Name:: php
# Recipe:: default
#
#
root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + '/resources/homebrew'
require root + '/providers/homebrew'
require 'etc'

homebrew "xdebug"

template "/usr/local/etc/php5/conf.d/xdebug.ini" do
  source "mods/xdebug.ini.erb"
end
