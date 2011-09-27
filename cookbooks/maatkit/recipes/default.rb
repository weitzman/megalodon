# Cookbook Name:: varnish
# Recipe:: default


#sudo -H cpan DBI::DBD DBD::mysql
bash "install DBD::mysql" do
  "sudo perl -MCPAN -e 'install Bundle::DBD::mysql'"
end

package "maatkit"
