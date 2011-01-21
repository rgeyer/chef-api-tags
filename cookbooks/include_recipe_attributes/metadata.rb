maintainer       "Ryan J. Geyer"
maintainer_email "me@ryangeyer.com"
license          "All rights reserved"
description      "Installs/Configures include_recipe_attributes"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"


recipe "include_recipe_attributes::parent", "The parent recipe, which includes other recipes that should be able to access the attributes"
recipe "include_recipe_attributes::child", "The child recipe, included by include_recipe_attributes::parent which should be able to access the attributes which they share"

attribute "include_recipe_attributes/parent_only_1",
  :display_name => "Parent Only #1",
  :description => "An attribute which is only available to the parent recipe",
  :recipes => ["include_recipe_attributes::parent"],
  :required => "required"

attribute "include_recipe_attributes/parent_and_child_1",
  :display_name => "Parent & Child #1",
  :description => "An attribute which is available to both parent and child recipes",
  :recipes => ["include_recipe_attributes::parent", "include_recipe_attributes::child"],
  :required => "required"

attribute "include_recipe_attributes/parent_and_child_2",
  :display_name => "Parent & Child #2",
  :description => "An attribute which is available to both parent and child recipes",
  :recipes => ["include_recipe_attributes::parent", "include_recipe_attributes::child"]
