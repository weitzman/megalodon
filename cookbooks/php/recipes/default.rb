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

bash "Fix the default PEAR permissions and config" do
  code <<-EOS
    chmod -R ug+w $(brew --prefix)/lib/php
    pear config-set php_ini $(brew --prefix)/etc/php5/php.ini
  EOS
end

FileUtils.mkdir_p(node[:php][:scan_dir]) unless File.exists?(node[:php][:scan_dir])

template "#{node['php']['conf_dir']}/php.ini" do
  source "php.ini.erb"
  mode "0644"
end
