#
# Cookbook Name:: node
# Recipe:: default
#
#
root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + '/resources/homebrew'
require root + '/providers/homebrew'
require 'etc'

script "configuring nvm" do
  interpreter "bash"
  code <<-EOS
    curl http://npmjs.org/install.sh | sh
  EOS
end
