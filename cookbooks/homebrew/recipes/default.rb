#
# Cookbook Name:: homebrew
# Recipe:: homebrew
#

root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

require root + '/resources/homebrew'
require root + '/providers/homebrew'
require 'etc'

#directory "#{ENV['HOME']}/Developer" do
  #action :create
#end
#
directory "#{ENV['HOME']}/.megalodon" do
  action :create
end

execute "download homebrew installer" do
  command "/usr/bin/curl -sfL http://github.com/mxcl/homebrew/tarball/master | /usr/bin/tar xz -m --strip 1"
  #cwd     "#{ENV['HOME']}/Developer"
  not_if  "test -e ~/usr/local/bin/brew"
end

script "install_something" do
  interpreter "bash"
  code <<-EOS
  if [ -f ~/.cider.profile ]; then
    rm ~/.cider.profile
  fi
  if [ -f ~/.cider.profile.custom ]; then
    mv ~/.cider.profile.custom ~/.megalodon.profile.custom
  fi
  EOS
end

template "#{ENV['HOME']}/.megalodon.profile" do
  mode   0700
  owner  ENV['USER']
  group  Etc.getgrgid(Process.gid).name
  source "dot.profile.erb"
  variables({ :home => ENV['HOME'] })
end

%w(bash_profile bashrc zshrc).each do |config_file|
  execute "include megalodon environment into defaults for ~/.#{config_file}" do
    command "if [ -f ~/.#{config_file} ]; then echo 'source ~/.megalodon.profile' >> ~/.#{config_file}; fi"
    not_if  "grep -q 'megalodon.profile' ~/.#{config_file}"
  end
end

execute "setup megalodon profile sourcing in ~/.profile" do
  command "echo 'source ~/.megalodon.profile' >> ~/.profile"
  not_if  "grep -q 'megalodon.profile' ~/.profile"
end

homebrew "git"
script "updating homebrew from github" do
  interpreter "bash"
  code <<-EOS
    source ~/.megalodon.profile
    /usr/local/bin/brew update >> ~/.megalodon/brew.log 2>&1
  EOS
end
