#
# Cookbook Name:: sjis
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

bash "install locale def sjis" do
  code <<-EOL
    localedef -f SHIFT_JIS -i ja_JP ja_JP.SJIS
  EOL
end

cookbook_file "i18n" do
  mode 0644
  owner "root"
  group "root"
  path "/etc/sysconfig/i18n"
  action :create
end

#bash "add LANG" do
#  code <<- EOL
#    echo 'export LANG=ja_JP.SJIS' > /home/vagrant/.bashrc
#  EOL
#  not_if "cat /home/vagrant/.bashrc | grep -v export LANG"
#end
