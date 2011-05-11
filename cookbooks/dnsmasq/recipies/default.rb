# Cookbook Name:: dnsmasq
# Recipe:: default
#
homebrew "dnsmasq"

bash "copy-conf" do
  code <<-EOS
    cp /usr/local/Cellar/dnsmasq/2.57/dnsmasq.conf.example /usr/local/etc/dnsmasq.conf
  EOS
end

bash "copy plist firsttime" do
  code <<-EOS
    sudo ln -nfs /usr/local/Cellar/dnsmasq/2.57/uk.org.thekelleys.dnsmasq.plist /Library/LaunchDaemons/
    sudo launchctl load -wF /Library/LaunchDaemons/uk.org.thekelleys.dnsmasq.plist
  EOS
  not_if File.exists?("~/Library/LaunchAgents/org.elasticsearch.plist")
end

bash "copy new plist" do
  code <<-EOS
    sudo launchctl unload -w /Library/LaunchDaemons/uk.org.thekelleys.dnsmasq.plist
    sudo ln -nfs /usr/local/Cellar/dnsmasq/2.57/uk.org.thekelleys.dnsmasq.plist /Library/LaunchDaemons/
    sudo launchctl load -wF /Library/LaunchDaemons/uk.org.thekelleys.dnsmasq.plist
  EOS
  only_if File.exists?("/Library/LaunchDaemons/uk.org.thekelleys.dnsmasq.plist")
end

