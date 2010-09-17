name "Repository" 
description "Repository role for a machine that holds organization source code"
run_list "recipe[getting-started]" , "recipe[zlib]", "recipe[apache2]"  
# Attributes applied if the node doesn't have it set already.
#default_attributes()
# Attributes applied no matter what the node has set already.
#override_attributes()

