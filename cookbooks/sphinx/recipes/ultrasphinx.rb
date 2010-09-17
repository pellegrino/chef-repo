include_recipe "ruby" 
include_recipe "sphinx"


gem_package "ultrasphinx" do
  action :install 
end 
