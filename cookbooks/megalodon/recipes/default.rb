#
# Cookbook Name:: megalodon
# Recipe:: default
#
require 'highline/import'

# This feels super ghetto to do this in a recipe, but I don't
# know of a better place to put it.
def get_sudo_password(prompt="Enter Password")
   ask(prompt) {|q| q.echo = false}
end

prompt = "
Your password is needed so that we can run a couple commands as sudo to work
with OSX's built in apache, but we promise that's it.

Please enter your password:"

node[:sudo_pass] = get_sudo_password(prompt)

directory "#{ENV['HOME']}/.megalodon" do
  action :create
end

brew_prefix = `brew --prefix`.strip

directory "#{brew_prefix}/etc/megalodon" do
  action :create
end

directory "#{brew_prefix}/var/www" do
  action :create
end

directory "#{ENV['HOME']}/.megalodon/data_bags" do
  action :create
end

directory "#{ENV['HOME']}/Library/LaunchAgents" do
  action :create
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

package "git"
script "updating homebrew from github" do
  interpreter "bash"
  code <<-EOS
    source ~/.megalodon.profile
    /usr/local/bin/brew update >> ~/.megalodon/brew.log 2>&1
  EOS
end
