Chef::Log.info("From parent recipe, include_recipe_attributes/parent_only_1 == #{node[:include_recipe_attributes][:parent_only_1]}")
Chef::Log.info("From parent recipe, include_recipe_attributes/parent_and_child_1 == #{node[:include_recipe_attributes][:parent_and_child_1]}")
Chef::Log.info("From parent recipe, include_recipe_attributes/parent_and_child_2 == #{node[:include_recipe_attributes][:parent_and_child_2]}")

include_recipe "include_recipe_attributes::child"