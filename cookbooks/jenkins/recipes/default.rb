# Cookbook Name:: jenkins
# Recipe:: default
#
package "jenkins"

bash "copy plist firsttime" do
  code <<-EOS
    cp /usr/local/Cellar/jenkins/*/org.jenkins-ci.plist ~/Library/LaunchAgents/
    launchctl load -w ~/Library/LaunchAgents/org.jenkins-ci.plist
  EOS
  not_if File.exists?("~/Library/LaunchAgents/org.jenkins-ci.plist")
end

bash "copy new plist" do
  code <<-EOS
    launchctl unload -w ~/Library/LaunchAgents/org.jenkins-ci.plist
    cp /usr/local/Cellar/jenkins/*/org.jenkins-ci.plist ~/Library/LaunchAgents/
    launchctl load -w ~/Library/LaunchAgents/org.jenkins-ci.plist
  EOS
  only_if File.exists?("~/Library/LaunchAgents/org.jenkins-ci.plist")
end
