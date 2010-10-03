#
# Cookbook Name:: gitorious
# Recipe:: default
#
# Copyright 2010, quartieri.com.br
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential"
include_recipe "git"
include_recipe "git::server" 
include_recipe "imagemagick"
include_recipe "imagemagick::rmagick"
include_recipe "mysql::server"
include_recipe "sphinx"
include_recipe "sphinx::ultrasphinx"
include_recipe "activemq"
include_recipe "activemq::server"
include_recipe "memcached" 
include_recipe "passenger_enterprise::apache2" 
gitorious_packages = %w{
  libonig-dev
  libyaml-dev
  geoip-bin
  libgeoip-dev
  libgeoip1
}

gitorious_packages.each do |p|
  package p do
    action :install 
  end 
end

execute "Creating users" do
  command "adduser vitor --disabled-password --gecos '' ; adduser git --disabled-password --gecos ''; groupadd gitorious ; usermod -a -G gitorious vitor"
  not_if { ::File.exists?("/home/git") } 
end

execute "Creating gitorious directory" do
  command "mkdir -p /var/www/git.quartieri.com.br ; chown vitor:gitorious /var/www/git.quartieri.com.br ; chmod -R g+sw /var/www/git.quartieri.com.br"
  not_if { ::File.exists?("/var/www/git.quartieri.com.br") } 
end

# fetching gitorious source code
execute "Getting gitorious source code" do
  cwd "/var/www/git.quartieri.com.br"
  command "mkdir log ; mkdir conf ; git clone http://git.gitorious.org/gitorious/mainline.git gitorious" 
  not_if { ::File.exists?("/var/www/git.quartieri.com.br/gitorious") } 
end

execute "Preparing gitorious directory" do
  cwd "/var/www/git.quartieri.com.br/gitorious"
  command "ln -s script/gitorious /usr/local/bin/gitorious ; rm public/.htaccess ; mkdir -p tmp/pids ; chmod ug+x script/* ; chmod -R g+w config/ log/ public/ tmp/"
   not_if { ::File.exists?("/usr/local/bin/gitorious") } 
end

execute "Creating a symlink to gitorious" do
  command "ln -s /var/www/git.quartieri.com.br/gitorious /var/www/gitorious" 
  not_if { ::File.exists?("/var/www/gitorious") } 
end 


link "/var/www/git.quartieri.com.br/gitorious/doc/templates/ubuntu/git-ultrasphinx" do
  to "/etc/init.d/git-ultrasphinx"
  not_if "test -f /etc/init.d/git-ultrasphinx"
end

link "/var/www/git.quartieri.com.br/gitorious/doc/templates/ubuntu/git-daemon" do
  to "/etc/init.d/git-daemon"
  not_if "test -f /etc/init.d/git-daemon" 
end

execute "run git-daemon and git-ultrasphinx services" do
  command "update-rc.d -f git-daemon start 99 2 3 4 5 . ; update-rc.d -f git-ultrasphinx start 99 2 3 4 5 ."
end 

execute "Creating home for git repositories" do
  command "usermod -a -G gitorious git ; mkdir -p /var/git/repositories ; mkdir -p /var/git/tarballs ; mkdir -p /var/git/tarball-work ; chown -R git:git /var/git"
  not_if { ::File.exists?("/var/git/repositories") } 
end

execute "Create .ssh/authorized_keys directory" do
  command "su git; mkdir ~/.ssh ; chmod 700 ~/.ssh ; touch ~/.ssh/authorized_keys"
  not_if { ::File.exists?("/home/git/.ssh/authorized_keys") } 
end


### Config files for gitorious

template "gitorious.yml" do
  path "/var/www/git.quartieri.com.br/gitorious/config/gitorious.yml"
  mode 0700
  source "gitorious.yml.erb" 
end

link "/var/www/git.quartieri.com.br/gitorious/config/broker.yml.example" do
  to"/var/www/git.quartieri.com.br/gitorious/config/broker.yml"
end




## TODO: Generate config/database.yml file from template

## TODO: Install gems 
# TODO: # 
# Create a template for /home/git/.bashrc
# execute "" do
#   command "
# # User specific aliases and functions
# export RUBY_HOME=/opt/ruby-enterprise
# export GEM_HOME=$RUBY_HOME/lib/ruby/gems/1.8/gems
# export PATH=$RUBY_HOME/bin:$PATH

# end 
