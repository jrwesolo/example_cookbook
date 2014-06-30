#
# Cookbook Name:: example_cookbook
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'yum-epel' if platform_family?('rhel')

package 'lighttpd'

template node['lighttpd']['config_file'] do
  source 'lighttpd.conf.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables(
    :document_root => node['lighttpd']['document_root'],
    :port => node['lighttpd']['port']
  )
  notifies :reload, 'service[lighttpd]', :delayed
end

directory node['lighttpd']['document_root'] do
  mode 0755
  owner 'root'
  group 'root'
  recursive true
end

template File.join(node['lighttpd']['document_root'], 'index.html') do
  mode 0644
  owner 'root'
  group 'root'
  variables(
    :message => node['lighttpd']['message']
  )
end

service 'lighttpd' do
  supports :status => true,
           :restart => true,
           :reload => true
  action [:enable, :start]
end
