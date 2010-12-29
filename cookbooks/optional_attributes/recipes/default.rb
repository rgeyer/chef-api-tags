#
# Cookbook Name:: optional_attributes
# Recipe:: default
#
# Copyright 2010, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

Chef::Log.info "The optional attribute contained (#{node[:optional_attributes][:optional]})"
Chef::Log.info "The required attribute contained (#{node[:optional_attributes][:required]})"
