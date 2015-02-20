#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
link "/etc/localtime" do
	to "/usr/share/zoneinfo/Japan"
end	
