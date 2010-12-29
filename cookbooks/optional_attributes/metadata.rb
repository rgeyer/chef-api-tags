maintainer       "Ryan J. Geyer"
maintainer_email "me@ryangeyer.com"
license          "All rights reserved"
description      "Installs/Configures optional_attributes"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

recipe "optional_attributes::default", "Demonstrates some weirdness with attributes"

attribute "optional_attributes/optional",
  :display_name => "Optional Attribute"

attribute "optional_attributes/required",
  :display_name => "Required Attribute",
  :required => true