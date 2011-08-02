# Cookbook Name:: mongodb
# Recipe:: default

package "mongodb"

bash "copy plist firsttime" do
  code <<-EOS
    cp /usr/local/Cellar/mongodb/*/org.mongodb.mongod.plist ~/Library/LaunchAgents/
    launchctl load -w ~/Library/LaunchAgents/org.mongodb.mongod.plist
  EOS
  not_if File.exists?("~/Library/LaunchAgents/org.mongodb.mongod.plist")
end

bash "copy new plist" do
  code <<-EOS
    launchctl unload -w ~/Library/LaunchAgents/org.mongodb.mongod.plist
    cp /usr/local/Cellar/mongodb/*/org.mongodb.mongod.plist ~/Library/LaunchAgents/
    launchctl load -w ~/Library/LaunchAgents/org.mongodb.mongod.plist
  EOS
  only_if File.exists?("~/Library/LaunchAgents/org.mongodb.mongod.plist")
end
