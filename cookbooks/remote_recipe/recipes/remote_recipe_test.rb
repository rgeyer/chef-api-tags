#
# Cookbook Name:: remote_recipe
# Recipe:: remote_recipe_test
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

send_hash = {
  :remote_recipe => {
    :one => "1",
    :two => "2"
  },
  :foo => "bar",
  :baz => "nothing"
}

Chef::Log.info("Sending the following hash to remote_recipe::remote_recipe_ping on the first server with the tag remote_recipe:target=true")
Chef::Log.info(send_hash.to_yaml)

remote_recipe "Ping" do
  recipe "remote_recipe::remote_recipe_ping"
  attributes(send_hash)
  recipients_tags ["remote_recipe:target=true"]
  scope :single
end