name "production"
description "For Prods!"
cookbook "apache", "= 0.1.3"
override_attributes({
  "pci" => {
    "in_scope" => true
  }
})
