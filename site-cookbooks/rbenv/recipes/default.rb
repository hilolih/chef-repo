#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

home = "/home/vagrant"

git "#{home}/.rbenv" do
  repository "https://github.com/sstephenson/rbenv.git"
  reference "master"
  user "vagrant"
  group "vagrant"
  action :sync
end

script "install_vagrant" do
  interpreter "bash"
  user "vagrant"
  group "vagrant"
  code <<-EOL
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    mkdir -p ~/.rbenv/plugins
    source ~/.bash_profile
  EOL
  environment 'HOME' => "/home/vagrant", "SHELL" => "/bin/bash"
  not_if "grep rbenv /home/vagrant/.bash_profile"
end


git "#{home}/.rbenv/plugins/ruby-build" do
  repository "https://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :sync
end

%w{
}.each do |version|
  execute "install ruby #{version}" do
  end
end
