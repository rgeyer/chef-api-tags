maintainer       "Ryan J. Geyer"
maintainer_email "me@ryangeyer.com"
license          "Apache2"
description      "Tests the RightScale remote_recipe Resource Provider"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

depends "skeme"

recipe "remote_recipe::remote_recipe_setup", "Run on two instances which you want to use to test remote recipe"
recipe "remote_recipe::remote_recipe_test", "Kicks off the whole test"
recipe "remote_recipe::remote_recipe_ping", "Called by remote_recipe::remote_recipe_test, then calls remote_recipe::remote_recipe_pong"
recipe "remote_recipe::remote_recipe_pong", "Called by remote_recipe::remote_recipe_ping"

attribute "remote_recipe/one",
  :required => "required",
  :recipes => ["remote_recipe::remote_recipe_ping","remote_recipe::remote_recipe_pong"]

attribute "remote_recipe/two",
  :required => "optional",
  :recipes => ["remote_recipe::remote_recipe_ping","remote_recipe::remote_recipe_pong"]

attribute "foo",
  :required => "optional",
  :recipes => ["remote_recipe::remote_recipe_ping","remote_recipe::remote_recipe_pong"]

attribute "baz",
  :required => "required",
  :recipes => ["remote_recipe::remote_recipe_pong"]