#
# Cookbook Name:: remote_recipe
# Recipe:: remote_recipe_ping
#
#  Copyright 2011 Ryan J. Geyer
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

require 'yaml'

Chef::Log.info("Entering Ping")

if(!node[:remote_recipe])
  Chef::Log.info("(FAIL) Expecting node[:remote_recipe] to be populated, but it was null")
else
  Chef::Log.info("(PASS) node[:remote_recipe] has contents")
  if(!node[:remote_recipe][:one] || node[:remote_recipe][:one] != "1")
    Chef::Log.info("(FAIL) Expecting node[:remote_recipe][:one] == 1 but it was either unset, or != 1")
  else
    Chef::Log.info("(PASS) node[:remote_recipe][:one] == #{node[:remote_recipe][:one]}")
  end
  if(!node[:remote_recipe][:two] || node[:remote_recipe][:two] != "2")
    Chef::Log.info("(FAIL) Expecting node[:remote_recipe][:two] == 2 but it was either unset, or != 2")
  else
    Chef::Log.info("(PASS) node[:remote_recipe][:two] == #{node[:remote_recipe][:two]}")
  end
end

if(!node[:foo])
  Chef::Log.info("(FAIL) Expected node[:foo] to be populated but it was null")
else
  Chef::Log.info("(PASS) node[:foo] has contents")
end

send_hash = {
  :remote_recipe => {
    :one => "1",
    :two => "2"
  },
  :foo => "bar",
  :baz => "nothing"
}

Chef::Log.info("Sending the following hash to remote_recipe::remote_recipe_pong to recipient list #{node[:remote_recipe][:from]}")
Chef::Log.info(send_hash.to_yaml)

# TODO: This assumes were running ping & pong on the same server.  node[:remote_recipe][:from] can not be used because
# I foolishly named this cookbook "remote_recipe". I'll have to refactor later.
remote_recipe "Ping" do
  recipe "remote_recipe::remote_recipe_pong"
  attributes(send_hash)
  recipients_tags ["remote_recipe:target=true"]
  scope :single
end
