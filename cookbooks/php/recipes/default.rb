#
# Cookbook Name:: php
# Recipe:: default
#
#
root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + '/resources/homebrew'
require root + '/providers/homebrew'
require 'etc'


homebrew "php" do 
  action :install
  options "--with-mysql --with-pgsql --with-mssql --with-imap --with-apache"
end

FileUtils.mkdir_p(node[:php][:scan_dir]) unless File.exists?(node[:php][:scan_dir])
