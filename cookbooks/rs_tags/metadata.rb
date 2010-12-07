maintainer       "Ryan J. Geyer"
maintainer_email "me@ryangeyer.com"
license          "All rights reserved"
description      "Installs/Configures rs_tags"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

recipe "rs_tags::default", "Does some testing with tags using Chef resources as well as the REST API to show some inconsistencies"

attribute "rs_tags/rest_pass",
  :display_name => "REST API Password",
  :description => "The password used to log into the RightScale dashboard, and the REST API",
  :recipes => ["rs_tags::default"],
  :required => true

attribute "rs_tags/rest_user",
  :display_name => "REST API Username",
  :description => "The email address used to log into the RightScale dashboard, and the REST API",
  :recipes => ["rs_tags::default"],
  :required => true

attribute "rs_tags/rest_acct_num",
  :display_name => "RightScale Account Number",
  :description => "Your RightScale account number",
  :recipes => ["rs_tags::default"],
  :required => true

attribute "rs_tags/server_name",
  :display_name => "RightScale dashboard nickname",
  :description => "The RightScale dashboard nickname, this should be set to ENV:RS_SERVER_NAME",
  :recipes => [ "rs_tags::default" ],
  :required => true