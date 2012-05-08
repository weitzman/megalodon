brew_prefix = `brew --prefix`.strip
directory "#{brew_prefix}/etc/megalodon/apache_confs" do
  action :create
end

# Setup databag directory for virtual hosts.
directory "#{ENV['HOME']}/.megalodon/data_bags/vhosts" do
  action :create
end

# Write out initial default vhost data bag item.
template "#{ENV['HOME']}/.megalodon/data_bags/vhosts/default.json" do
  source "default.json.erb"
  action :create
end

# Update built-in Apache with administrative privleges.
# TODO - Use Ruby auth bindings instead of AppleScript.
# {Ruby OSX Auth}[http://ruby-osxauth.rubyforge.org/]
execute "Include conf in Mac Apache with admin privileges" do
  command <<-EOS
  /usr/bin/osascript -e 'do shell script "echo \\"Include /usr/local/etc/megalodon/apache_confs/*.conf\\" >> /etc/apache2/httpd.conf" with administrator privileges'
  EOS
  not_if "grep '^Include /usr/local/etc/megalodon/apache_confs' /etc/apache2/httpd.conf"
end

megalodon_app "000-default" do
  docroot node["megalodon"]["docroot"]
  server_name "localhost"
  template "default.conf.erb"
end

vhosts = data_bag("vhosts")
vhosts.each do |vhost_name|
  vhost = data_bag_item("vhosts", vhost_name)
  megalodon_app vhost['id'] do
    docroot vhost['docroot']
    server_name vhost['servername']
    template "vhost.conf.erb"
  end
end

template "#{node[:megalodon][:brew_prefix]}/etc/megalodon/apache_confs/php5.conf" do
  source "php5.conf.erb"
  action :create
end
