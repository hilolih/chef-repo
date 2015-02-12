#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{httpd php php-mysql php-soap php-pgsql php-mbstring php-devel php-pear}.each do |pkg|
  package pkg do
    action :install
  end
end

template "/var/www/html/phpinfo.php" do
  source "phpinfo.php"
  owner "apache"
  group "apache"
  mode 0644
end

template "/etc/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode 0644
  variables({
    "upload_max_filesize" => "40M",
    "post_max_size" => "40M",
    "mbstring_internal_encoding" => "SJIS",
    "mbstring_encoding_translation" => "OFF",
    "mbstring_http_input" => "SJIS",
    "mbstring_http_output" => "SJIS",
    "mbstring_detect_order" => ";",
    "default_charset" => "default_charset = \"SJIS\"",
    "default_mimetype" => ";",
  })
  notifies :restart, "service[httpd]"
end

service "httpd" do
  action [:start, :enable]
end
