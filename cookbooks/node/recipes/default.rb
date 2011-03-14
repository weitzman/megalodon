#
# Cookbook Name:: node
# Recipe:: default
#
#
root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + '/resources/homebrew'
require root + '/providers/homebrew'
require 'etc'


### install a bunch of utils
%w(rlwrap node).each do |pkg|
  homebrew pkg
end

bash "install npm" do
  code <<-EOS
    curl http://npmjs.org/install.sh | sh
  EOS
end

#script "configuring ndistro" do
  #interpreter "bash"
  #code <<-EOS
    #source ~/.cinderella.profile
    #cd #{ENV['HOME']}/Developer/bin
#
    #curl -# -L http://github.com/visionmedia/ndistro/raw/master/bin/ndistro > ndistro 2> ~/.cinderella.log
    #chmod 0755 ndistro
  #EOS
#end
