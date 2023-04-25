# @summary Applies security settings for nginx
#
# Sets a headers.conf file for nginx, adds directive to include header
#
# @example
#   include nginxcustom
class nginxcustom {
  #File resource for headers.conf
  file { '/etc/puppetlabs/nginx/headers.conf':
    ensure => file,
    group  => 'root',
    owner  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/nginxcustom/headers.conf',
  }
  #Nginx directive to add include statement 
  pe_nginx::directive {
    'include custom headers':
      directive_ensure => 'present',
      target           => '/etc/puppetlabs/nginx/conf.d/proxy.conf',
      directive_name   => 'include',
      value            => 'headers.conf',
      server_context   => $::fqdn,  #lint:ignore:top_scope_facts lint:ignore:legacy_facts
  }
}
