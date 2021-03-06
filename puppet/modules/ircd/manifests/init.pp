class ircd {
  package {'ircd-hybrid':
    ensure => latest,
  }

  file {'etc_ircd_conf':
    ensure  => present,
    path    => '/etc/ircd/ircd.conf',
    owner   => 'ircd',
    group   => 'ircd',
    mode    => '0640',
    source  => "puppet:///modules/ircd/ircd.conf",
    require => Package['ircd-hybrid'],
    notify  => Service['ircd'],
  }

  service {'ircd':
    ensure     => 'running',
    enable     => true,
    restart    => '/sbin/service ircd reload',
    hasrestart => true,
    hasstatus  => true,
    require    => Package['ircd-hybrid'],
  }
}

