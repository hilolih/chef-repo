#
# Cookbook Name:: mongodb
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "mongodb.repo" do
  mode 0644
  owner "root"
  group "root"
  path "/etc/yum.repos.d/mongodb.repo"
  action :create_if_missing
end

%w{
mongodb-org
mongodb-org-mongos
mongodb-org-server
mongodb-org-shell
mongodb-org-tools
}.each do |pkg|
  package pkg do
    action :install
  end
end

service "mongod" do
  action [:enable, :start]
end
