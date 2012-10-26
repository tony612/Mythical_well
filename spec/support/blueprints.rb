#require 'factory_girl'                                 
#require 'factory_girl/syntax/blueprint'                
#require 'factory_girl/syntax/make'                     
                                                       
#User.blueprint do                                      
#  u_name  = Faker::Name.name                           
#                                                           
#  sequence(:username) { |n| "user_#{n}" }              
#  name                { u_name }                       
#  email               { Faker::Internet.email(u_name) }
#  location            { Faker::Address.city }          
#  #introduction        { Faker::Lorem.sentence }        
#  password            { 'password' }                   
#end                                                    

