name "Repository" 
description "Repository role for a machine that holds organization source code"
run_list "recipe[application]", "recipe[sphinx]", "recipe[gitorious]"
override_attributes :apps => {
  :my_app => {
    :production => { 
      :run_migrations => true,
      :force => false    
    }, 
    :staging => { 
      :run_migrations => true , 
      :force => true 
    } 
  }

}


# Attributes applied if the node doesn't have it set already.
#default_attributes()
# Attributes applied no matter what the node has set already.
#override_attributes()

