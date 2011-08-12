#
# Cookbook Name:: php
# Recipe:: default
#
#

package "php" do
  action :install
  options "--with-mysql --with-pgsql --with-mssql --with-imap --with-fpm --with-cgi"
end

bash "Fix the default PEAR permissions and config" do
  code <<-EOS
    chmod -R ug+w $(brew --prefix php)/lib/php
    pear config-set php_ini $(brew --prefix)/etc/php5/php.ini
  EOS
end

directory node['php']['scan_dir'] do
  action :create
end

directory "#{node['php']['conf_dir']}/fpm" do
  action :create
end

directory "/usr/local/var/php5/run" do
  action :create
  recursive true
end

template "#{node['php']['conf_dir']}/php.ini" do
  source "php.ini.erb"
  mode "0644"
end

template "#{node['php']['conf_dir']}/fpm/php-fpm.conf" do
  source "php-fpm.conf.erb"
  mode "0644"
end

template "#{ENV['HOME']}/Library/LaunchAgents/net.php.php-fpm.plist" do
  source "net.php.php-fpm.plist.erb"
end

