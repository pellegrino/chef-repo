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

execute "Creating gitorious group" do
  command "groupadd gitorious"
  command "usermod -a -G gitorious vitor" 
end

execute "Creating gitorious directory" do
  command "mkdir -p /var/www/git.quartieri.com.br"
  command "chown christian:gitorious /var/www/git.quartieri.com.br"
  command "chmod -R g+sw /var/www/git.quartieri.com.br" 
  not_if { ::File.exists?("/var/www/git.quartieri.com.br") } 
end

# fetching gitorious source code
execute "Getting gitorious source code" do
  cwd "/var/www/git.quartieri.com.br"
  command "mkdir log ; mkdir conf" 
  command  "git clone http://git.gitorious.org/gitorious/mainline.git gitorious"
  not_if { ::File.exists?("/var/www/git.quartieri.com.br/gitorious") } 
end

execute "Preparing gitorious directory" do
  cwd "/var/www/git.quartieri.com.br/gitorious"
  command "ln -s script/gitorious /usr/local/bin/gitorious"
  command "rm public/.htaccess"
  command "mkdir -p tmp/pids"
  command "ug+x script/*"
  command "chmod -R g+w config/ log/ public/ tmp/" 
  not_if { ::File.exists?("/usr/local/bin/gitorious") } 
end
