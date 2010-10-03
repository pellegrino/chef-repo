current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "pellegrino"
client_key               "#{current_dir}/pellegrino.pem"
validation_client_name   "quartieri-validator"
validation_key           "#{current_dir}/quartieri-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/quartieri"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
