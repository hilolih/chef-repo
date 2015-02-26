#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{
  zsh 
  vim 
  git 
  man 
  lsof
  ruby
  ImageMagick 
  ImageMagick-devel
  lftp
  ntp
  patch
}.each do |pkg|
  package pkg do
    action :install
  end
end

dotfiles = "/home/vagrant/dotfiles"

git dotfiles do
  repository "https://github.com/hilolih/dotfiles.git"
  reference "master"
  action :checkout
  user "vagrant"
  group "vagrant"
end

bash "install_dotfiles" do
  cwd dotfiles
  user "vagrant"
  group "vagrant"
  code <<-EOL
    ./symlink.rb
  EOL
  environment 'HOME' => "/home/vagrant"
end

%w{github_id_rsa config}.each do |file|
  cookbook_file file do
    mode 0600
    owner "vagrant"
    group "vagrant"
    path "/home/vagrant/.ssh/#{file}"
    action :create_if_missing
  end
end

bash "git init" do
  cwd dotfiles
  user "vagrant"
  group "vagrant"
  code <<-EOL
    git config --global user.name "hiroshi shimoda"
    git config --global user.email "hilolih@gmail.com"
    git config --global merge.tool vimdiff
    git config --global color.diff auto
    git config --global color.status auto
    git config --global color.branch auto
  EOL
  environment 'HOME' => "/home/vagrant"
end

#bash "git remote" do
#  cwd dotfiles
#  user "vagrant"
#  group "vagrant"
#  environment 'HOME' => "/home/vagrant"
#  code <<-EOL
#    git remote set-url origin ssh://github.com/hilolih/dotfiles.git
#    git remote rename origin github
#  EOL
#  not_if "git remote -v | grep origin"
#end


service "ntpd" do
  action [:enable, :start]
end

cookbook_file "ntp.conf" do
  mode 0644
  owner "root"
  group "root"
  path "/etc/ntp.conf"
  not_if "grep mfeed /etc/ntp.conf"
end
