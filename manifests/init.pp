# == Class: rtadvd
#
# Full description of class rtadvd here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'rtadvd':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class rtadvd (
  $service_ensure = 'running',
  $service_enable = true,
  $service_flags  = undef,
  $interfaces     = {},
){


  if (versioncmp('6.4', $::facts['kernelversion']) == -1) {
    $service_name = 'rtadvd'
  } else {
    $service_name = 'rad'
  }

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
    flags  => $service_flags,
  }

  if ($service_name == 'rad') {
    file { '/etc/rad.conf':
      owner   => 'root',
      group   => 'wheel',
      mode    => '0644',
      content => template('rtadvd/rad.conf.erb'),
      notify  => Service[$service_name],
    }
  }

}
