maintainer       "quartieri.com.br"
maintainer_email "vitor@quartieri.com.br"
license          "Apache 2.0"
description      "Installs/Configures gitorious"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

depends "build-essential"
depends "git"
depends "imagemagick"
depends "imagemagick::rmagick"
depends "mysql"
depends "sphinx"
depends "activemq" 

supports "ubuntu" 
