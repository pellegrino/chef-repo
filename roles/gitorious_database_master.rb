{
  "name": "gitorious_database_master",
  "chef_type": "role",
  "json_class": "Chef::Role",
  "default_attributes": {
  },
  "description": "",
  "run_list": [
    "recipe[mysql::server]",
    "recipe[database::master]"
  ],
  "override_attributes": {
  }
}
