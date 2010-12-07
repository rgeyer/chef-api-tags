#
# Cookbook Name:: rs_tags
# Recipe:: default
#
# Copyright 2010, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

######
# Unrelated to this cookbook, create a "unisex" repo for stuff that applies to windows or linux
# add a "tag normalizer" to this new repo.  It'll take tags from the dashboard/server_collection
# and make sure it's duplicated in the REST API.  Might also consider doing this with an "orchestrator"
# server..

# Install Rest_Connection for later use
bash "Install rest_connection gem" do
  code "/opt/rightscale/sandbox/bin/gem install rest_connection"
end

directory "/etc/rest_connection" do
  recursive true
  action :create
end

template "/etc/rest_connection/rest_api_config.yaml" do
  source "rest_api_config.yaml.erb"
end

# Add a tag in the dashboard tag:source=dashboard

# Retrieve the tag with server_collection (should succeed)
server_collection "dashboard_tagged" do
  tags ["tag:source=dashboard"]
end

ruby_block "Check for presence of dashboard tags in server_collection" do
  block do
    dashboard_tagged_count = node[:server_collection]["dashboard_tagged"].size
    Chef::Log::info "Expecting 1 server in the server_collection tagged with tag:source=dashboard, found #{dashboard_tagged_count}"
  end
end

# Retrieve the tag with the Ruby/REST API (should fail)
ruby_block "Check for presense of dashboard tags in rest_connection" do
  block do
    require 'rubygems'
    require 'rest_connection'

    tag_result = Tag.search('server', ["tag:source=dashboard"])
    Chef::Log::info "Expecting 1 server returned by REST API for tag:source=dashboard, found #{tag_result.size}"
  end
end

# Add a tag with the chef resource tag:source=chef
# Might need to put this in a Ruby block so that it's evaluated in order with the rest of the resources, though
# having it evaluated (and added) before the other resources run won't really be detrimental to the test.
right_link_tag "tag:source=chef"

# Retrieve that tag with server_collection (should succeed)
server_collection "chef_tagged" do
  tags ["tag:source=chef"]
end

ruby_block "Check for presence of chef tags in server_collection" do
  block do
    chef_tagged_count = node[:server_collection]["chef_tagged"].size
    Chef::Log::info "Expecting 1 server in the server_collection tagged with tag:source=chef, found #{chef_tagged_count}"
  end
end

# Retrieve the tag with Ruby/REST API (should fail)
ruby_block "Check for presense of chef tags in rest_connection" do
  block do
    require 'rubygems'
    require 'rest_connection'

    tag_result = Tag.search('server', ["tag:source=chef"])
    Chef::Log::info "Expecting 1 server returned by REST API for tag:source=chef, found #{tag_result.size}"
  end
end

# Add a tag with the Ruby API tag:source=rest
ruby_block "Add tag with REST api" do
  block do
    require 'rubygems'
    require 'rest_connection'

    thisServer = Server.find(:first) { |s| s.nickname == node[:rs_tags][:server_name] }
    Tag.set(thisServer.href, ["tag:source=rest"])
    # Note that tag is not added to dashboard! -- Create recipe to "reset" this tag.
  end
end

# Retrieve the tag with server_collection (should fail)
server_collection "rest_tagged" do
  tags ["tag:source=rest"]
end

ruby_block "Check for presence of rest tags in server_collection" do
  block do
    rest_tagged_count = node[:server_collection]["rest_tagged"].size
    Chef::Log::info "Expecting 1 server in the server_collection tagged with tag:source=rest, found #{rest_tagged_count}"
  end
end

# Retrieve the tag with the Ruby API (should succeed)
ruby_block "Check for presense of rest tags in rest_connection" do
  block do
    require 'rubygems'
    require 'rest_connection'

    tag_result = Tag.search('server', ["tag:source=rest"])
    Chef::Log::info "Expecting 1 server returned by REST API for tag:source=rest, found #{tag_result.size}"

    thisServer = Server.find(:first) { |s| s.nickname == node[:rs_tags][:server_name] }
    Chef::Log::info "Even though the above test returned #{tag_result.size}, the list of tags for this server looks like #{thisServer.tags.inspect}"
  end
end
