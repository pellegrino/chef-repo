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
include_recipe "imagemagick"
include_recipe "imagemagick::rmagick"
include_recipe "mysql::server"
include_recipe "sphinx"

gitorious_packages = %w{
  libonig-dev
  libyaml-dev
  geoip-bin
  libgeoip-dev
  libgeoip1
}

