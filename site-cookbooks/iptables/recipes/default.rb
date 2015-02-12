#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/sysconfig/iptables" do
	source "iptables.erb"
	mode 0600
  # 8080: jenkins
	variables( dports: [22, 80, 443, 8080] )
end

service "iptables" do
	action :restart
end
