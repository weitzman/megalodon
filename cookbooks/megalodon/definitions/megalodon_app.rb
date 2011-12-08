# Cookbook Name:: megalodon
# Definition:: megalodon_app
#

define :megalodon_app, :template => "megalodon_app.conf.erb", :enable => true do

  application_name = params[:name]

  template "/usr/local/etc/megalodon/apache_confs/#{application_name}.conf" do
    source params[:template]
    mode 0644
    if params[:cookbook]
      cookbook params[:cookbook]
    end
    variables(
      :application_name => application_name,
      :params => params
    )
  end
end

