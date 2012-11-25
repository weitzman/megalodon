#
# Cookbook Name:: mariadb 
# Recipe:: default
#
# Copyright 2008-2009, Opscode, Inc.
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

package "mariadb"

brew_prefix = `brew --prefix`.strip

template "/usr/local/etc/my.cnf" do
  source "my.cnf.erb"
end

# OSX before 10.8 didn't have egrep, but grep -P worked similarly.
grep = %x[which egrep].strip || "grep -P"

bash "post-install" do
  code <<-EOH
    (mysql_install_db --basedir=#{brew_prefix}/opt/mariadb --user=$USER)
    (cp /usr/local/Cellar/mariadb/5.*/homebrew.mxcl.*.plist ~/Library/LaunchAgents)
    (launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.*.plist)
  EOH
  not_if "mysql -e 'SHOW DATABASES'| #{grep} '^test|^mysql'"
end

logdir = File.dirname(node[:mysql][:tunable][:log_slow_queries])
FileUtils.mkdir_p(logdir) unless File.exists?(logdir)
