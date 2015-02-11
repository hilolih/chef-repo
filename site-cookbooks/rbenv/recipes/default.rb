#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

home = "/home/vagrant"
RBENV_SCRIPT = "/etc/profile.d/rbenv.sh"

# for 2.2.0
package "libffi-devel" do
  action :install
end

git "#{home}/.rbenv" do
  repository "https://github.com/sstephenson/rbenv.git"
  reference "master"
  user "vagrant"
  group "vagrant"
  action :sync
end

cookbook_file "rbenv.sh" do
  mode 0644
  owner "root"
  group "root"
  path RBENV_SCRIPT
  action :create_if_missing
end

git "#{home}/.rbenv/plugins/ruby-build" do
  repository "https://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :sync
end

#script "install_vagrant" do
#  interpreter "bash"
#  user "vagrant"
#  group "vagrant"
#  #code <<-EOL
#  #  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
#  #  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
#  #  mkdir -p ~/.rbenv/plugins
#  #  source ~/.bash_profile
#  #EOL
#  environment 'HOME' => "/home/vagrant", "SHELL" => "/bin/bash"
#  not_if "grep rbenv /home/vagrant/.bash_profile"
#end


%w{
  bundler
  pry
  pry-doc
}.each do |gem|
  execute "install ruby #{gem}" do
    command "source #{RBENV_SCRIPT}; gem install #{gem}; rbenv rehash"
    not_if "source #{RBENV_SCRIPT}; gem list | grep #{gem}"
  end
end
