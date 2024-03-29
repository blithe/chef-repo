#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2013, Blithe Rocher
#
# All rights reserved - Do Not Redistribute
#

package "httpd" do
  action :install
end

# execute only if the file exists (prevents from failing with error)
execute "mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.bak" do
  only_if do
    File.exist?("/etc/httpd/conf.d/welcome.conf")
  end
  notifies :restart, "service[httpd]"
end

node['apache']['sites'].each do |site_name, site_data|
  document_root = "/srv/apache/#{site_name}"

  template "/etc/httpd/conf.d/#{site_name}.conf" do
    source "custom.erb"
    mode "0644"
    variables(
      :document_root => document_root,
      :port => site_data['port']
    )
    notifies :restart, "service[httpd]"
  end

  directory document_root do
    mode "0755"
    recursive true
  end

  template "#{document_root}/index.html" do
    source "index.html.erb"
    mode "0644"
    variables(
      :site_name => site_name,
      :site_image_url => site_data['image_url'],
      :port => site_data['port']
    )
  end
end

service "httpd" do
  action [ :enable, :start ]
end
