#
# Cookbook Name:: fluentd
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "sysctl.conf" do
  mode 0644
  owner "root"
  group "root"
  path "/etc/sysctl.conf"
  not_if "grep tcp_tw_recycle /etc/sysctl.conf"
end

cookbook_file "limits.conf" do
  mode 0644
  owner "root"
  group "root"
  path "/etc/security/limits.conf"
  not_if "grep tcp_tw_recycle /etc/security/limits.conf"
end

bash "install td-agent" do
  code <<-EOL
    curl -L http://toolbelt.treasuredata.com/sh/install-redhat.sh | sh 
  EOL
end

service "td-agent" do
  action [:enable, :start]
end
