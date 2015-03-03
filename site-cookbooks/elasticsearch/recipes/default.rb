#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "elasticsearch.repo" do
  mode 0644
  owner "root"
  group "root"
  path "/etc/yum.repos.d/elasticsearch.repo"
  action :create_if_missing
end

%w{
elasticsearch
}.each do |pkg|
  package pkg do
    action :install
  end
end

service "elasticsearch" do
  action [:enable, :start]
end

%w{
  gcc
  libcurl-devel
}.each do |pkg|
  package pkg do
    action :install
  end
end
elas_gem = "fluent-plugin-elasticsearch"
bash "install fluent gem" do
  code <<-"EOL"
    /usr/lib64/fluent/ruby/bin/fluent-gem install #{elas_gem}
  EOL
  not_if "/usr/lib64/fluent/ruby/bin/fluent-gem list --local | grep #{elas_gem}"
end
