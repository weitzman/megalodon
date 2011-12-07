# Cookbook Name:: maatkit
# Recipe:: default


bash "install DBD::mysql" do
  "sudo perl -MCPAN -e 'install Bundle::DBD::mysql'"
  not_if "/usr/bin/env perl -e 'use DBD::mysql'"
end

package "maatkit"
