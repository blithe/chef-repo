name "ntp_server"
description "NTP Server"
run_list "recipe[ntp]"
default_attributes({
  "ntp" => {
    "is_server" => true,
    "servers" => [
      '0.north-america.pool.ntp.org',
      '1.north-america.pool.ntp.org',
      '2.north-america.pool.ntp.org',
      '3.north-america.pool.ntp.org'    ]
  }
})

