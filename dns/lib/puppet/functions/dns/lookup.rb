# DNS Puppet Module - `dns::lookup` Function
# ------------------------------------------

Puppet::Functions.create_function(:'dns::lookup') do
  dispatch :dns_lookup do
    param 'Stdlib::Fqdn', :fqdn
    return_type 'Array[Stdlib::IP::Address]'
  end

  def dns_lookup(fqdn)
    Resolv::DNS.new.getaddresses(fqdn).collect(&:to_s)
  end
end
