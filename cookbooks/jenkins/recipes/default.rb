#
# Cookbook Name:: xhprof
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

homebrew "jenkins"

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
