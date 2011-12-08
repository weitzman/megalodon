#
# Cookbook Name:: php
# Recipe:: default
#
#

package "php" do
  action :install
  options "--with-mysql --with-imap --with-apache --with-cgi"
end

bash "Fix the default PEAR permissions and config" do
  code <<-EOS
    chmod -R ug+w $(brew --prefix php)/lib/php
    pear config-set php_ini $(brew --prefix php)/etc/php5/php.ini
    pecl config-set php_suffix /$(brew --prefix php| awk -F'/' '{print $6}')/bin/php
  EOS
end

FileUtils.mkdir_p(node[:php][:scan_dir]) unless File.exists?(node[:php][:scan_dir])

template "#{node['php']['conf_dir']}/php.ini" do
  source "php.ini.erb"
  mode "0644"
end
