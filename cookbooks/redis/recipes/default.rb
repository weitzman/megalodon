# Cookbook Name:: redis
# Recipe:: default

package "redis"

plist="homebrew.mxcl.redis.plist"

bash "copy plist firsttime" do
  code <<-EOS
  (cp /usr/local/Cellar/redis/*/#{plist} ~/Library/LaunchAgents/)
  (launchctl load -w ~/Library/LaunchAgents/#{plist})
  EOS
  not_if File.exists?("~/Library/LaunchAgents/#{plist}")
end

bash "copy new plist" do
  code <<-EOS
    launchctl unload -w ~/Library/LaunchAgents/#{plist}
    cp /usr/local/Cellar/redis/*/#{plist} ~/Library/LaunchAgents/
    launchctl load -w ~/Library/LaunchAgents/#{plist}
  EOS
  only_if File.exists?("~/Library/LaunchAgents/#{plist}")
end
