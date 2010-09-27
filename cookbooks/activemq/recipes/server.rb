include_recipe "activemq" 

unless File.exists?("/etc/init.d/activemq")
  remote_file "/tmp/apache-activemq" do
    source "http://launchpadlibrarian.net/15645459/activemq"
    mode "0644"
  end
  execute "mv activemq /etc/init.d/activemq"
  execute "chmod +x /etc/init.d/activemq" 
end 
