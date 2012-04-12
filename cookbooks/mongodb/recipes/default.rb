# Cookbook Name:: mongodb
# Recipe:: default

package "mongodb"

plist="homebrew.mxcl.mongodb.plist"

bash "copy plist firsttime" do
  code <<-EOS
  (cp /usr/local/Cellar/mongodb/*/#{plist} ~/Library/LaunchAgents/)
  (launchctl load -w ~/Library/LaunchAgents/#{plist})
  EOS
  not_if File.exists?("~/Library/LaunchAgents/#{plist}")
end

bash "copy new plist" do
  code <<-EOS
    launchctl unload -w ~/Library/LaunchAgents/#{plist}
    cp /usr/local/Cellar/mongodb/*/#{plist} ~/Library/LaunchAgents/
    launchctl load -w ~/Library/LaunchAgents/#{plist}
  EOS
  only_if File.exists?("~/Library/LaunchAgents/#{plist}")
end
