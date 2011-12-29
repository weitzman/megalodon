#
# Cookbook Name:: megalodon
# Recipe:: misc
#

#root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

#require root + '/resources/homebrew'
#require root + '/providers/homebrew'
include_recipe 'homebrew'

%w(bash-completion xz coreutils patchutils sqlite wget markdown ctags).each do |pkg|
  package pkg
end
