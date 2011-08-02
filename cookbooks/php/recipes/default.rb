#
# Cookbook Name:: php
# Recipe:: default
#
#

package "php" do
  action :install
  options "--with-mysql --with-pgsql --with-mssql --with-imap --with-apache"
end

bash "Add php to apache conf" do
  code <<-EOS
  sudo sed -i -e "s%^#LoadModule php5_module libexec/apache2/libphp5.so%LoadModule php5_module $(brew --prefix php)/libexec/apache2/libphp5.so%" /etc/apache2/httpd.conf
  sudo sed -i -e "s%^#Include /private/etc/apache2/extra/httpd-vhosts.conf%Include /private/etc/apache2/extra/httpd-vhosts.conf%" /etc/apache2/httpd.conf
  EOS
  not_if "grep '^LoadModule php5_module' /etc/apache2/httpd.conf"
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
