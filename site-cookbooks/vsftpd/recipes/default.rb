#
# Cookbook Name:: vsftpd
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "xinetd" do
  action :install
end

package "vsftpd" do
  action :install
end

service "vsftpd" do
  action [:enable, :start]
end
