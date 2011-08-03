package "nginx"

bash "copy plist firsttime" do
  code <<-EOS
    cp /usr/local/Cellar/nginx/*/org.nginx.nginx.plist ~/Library/LaunchAgents/
    launchctl load -w ~/Library/LaunchAgents/org.nginx.nginx.plist
  EOS
  not_if File.exists?("~/Library/LaunchAgents/org.nginx.nginx.plist")
end

bash "copy new plist" do
  code <<-EOS
    launchctl unload -w ~/Library/LaunchAgents/org.nginx.nginx.plist
    cp /usr/local/Cellar/nginx/*/org.nginx.nginx.plist ~/Library/LaunchAgents/
    launchctl load -w ~/Library/LaunchAgents/org.nginx.nginx.plist
  EOS
  only_if File.exists?("~/Library/LaunchAgents/org.nginx.nginx.plist")
end

directory "/usr/local/etc/nginx/conf.d" do
  action :create
end

directory "/usr/local/etc/nginx/sites-available" do
  action :create
end

directory "/usr/local/etc/nginx/sites-enabled" do
  action :create
end

directory "/usr/local/var/log/nginx" do
  action :create
end

template  "/usr/local/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
end

template  "/usr/local/etc/nginx/fastcgi_params" do
  source "fastcgi_params.erb"
end

template  "/usr/local/etc/nginx/sites-available/default.conf" do
  source "default.conf.erb"
end

link "/usr/local/etc/nginx/sites-enabled/default.conf" do
  to "/usr/local/etc/nginx/sites-available/default.conf"
end

=begin

nginx_app app['id'] do
  docroot path
  template 'app_nginx.conf.erb'
  server_name "#{app['id']}.#{node['domain']}"
  server_aliases server_aliases
  log_dir node['nginx']['log_dir']
  port '8080'
end

nginx_site "default" do
  enable false
end
=end
