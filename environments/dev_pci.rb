name "dev_pci"
description "For Prods!"
cookbook "apache", "= 0.2.1"
override_attributes({
  "pci" => {
    "in_scope" => true
  }
})
