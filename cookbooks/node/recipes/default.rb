#
# Cookbook Name:: node
# Recipe:: default
#
#

script "configuring nvm" do
  interpreter "bash"
  code <<-EOS
    curl http://npmjs.org/install.sh | sh
  EOS
end
