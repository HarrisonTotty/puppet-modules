type Fwutils::Domain = Variant[
  Stdlib::Fqdn,
  Array[Stdlib::Fqdn],
  Stdlib::IP::Address,
  Array[Stdlib::IP::Address]
]
