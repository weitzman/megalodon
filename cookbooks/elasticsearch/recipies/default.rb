# Cookbook Name:: elasticsearch
# Recipe:: default
#
package "eslasticsearch"

bash "copy plist firsttime" do
  code <<-EOS
    mkdir -p ~/Library/LaunchAgents
    ln -nfs /usr/local/Cellar/elasticsearch/0.16.2/org.elasticsearch.plist ~/Library/LaunchAgents/
    launchctl load -wF ~/Library/LaunchAgents/org.elasticsearch.plist
  EOS
  not_if File.exists?("~/Library/LaunchAgents/org.elasticsearch.plist")
end

bash "copy new plist" do
  code <<-EOS
    launchctl unload -w ~/Library/LaunchAgents/org.elasticsearch.plist
    ln -nfs /usr/local/Cellar/elasticsearch/0.16.2/org.elasticsearch.plist ~/Library/LaunchAgents/
    launchctl load -wF ~/Library/LaunchAgents/org.elasticsearch.plist
  EOS
  only_if File.exists?("~/Library/LaunchAgents/org.elasticsearch.plist")
end

