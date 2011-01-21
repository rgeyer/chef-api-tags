Chef::Log.info("From parent recipe (chef compile), include_recipe_attributes/parent_only_1 == #{node[:include_recipe_attributes][:parent_only_1]}")
Chef::Log.info("From parent recipe (chef compile), include_recipe_attributes/parent_and_child_1 == #{node[:include_recipe_attributes][:parent_and_child_1]}")
Chef::Log.info("From parent recipe (chef compile), include_recipe_attributes/parent_and_child_2 == #{node[:include_recipe_attributes][:parent_and_child_2]}")

ruby_block "In a chef resource" do
  block do
    Chef::Log.info("From parent recipe (chef resource), include_recipe_attributes/parent_only_1 == #{node[:include_recipe_attributes][:parent_only_1]}")
    Chef::Log.info("From parent recipe (chef resource), include_recipe_attributes/parent_and_child_1 == #{node[:include_recipe_attributes][:parent_and_child_1]}")
    Chef::Log.info("From parent recipe (chef resource), include_recipe_attributes/parent_and_child_2 == #{node[:include_recipe_attributes][:parent_and_child_2]}")
  end
end

include_recipe "include_recipe_attributes::child"