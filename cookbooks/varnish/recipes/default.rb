# Cookbook Name:: varnish
# Recipe:: default

package "varnish"

directory "#{brew_prefix}/etc/varnish" do
  action :create
end

template "/usr/local/etc/varnish/default.vcl" do
  source "default.vcl.erb"
  #owner "root"
  #group "root"
  mode 0644
end

#template "#{node[:varnish][:default]}" do
#  source "ubuntu-default.erb"
#  owner "root"
#  group "root"
#  mode 0644
#end
#
