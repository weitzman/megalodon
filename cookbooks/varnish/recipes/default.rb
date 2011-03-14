# Cookbook Name:: varnish
# Recipe:: default

homebrew "varnish"

template "#{node[:varnish][:dir]}/default.vcl" do
  source "default.vcl.erb"
  owner "root"
  group "root"
  mode 0644
end

template "#{node[:varnish][:default]}" do
  source "ubuntu-default.erb"
  owner "root"
  group "root"
  mode 0644
end

service "varnish" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

service "varnishlog" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end
