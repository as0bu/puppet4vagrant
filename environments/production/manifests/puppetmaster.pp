node master {

  #include puppetdb
  #include puppetdb::master::config
  
  class { 'puppetdb':
    manage_firewall => false,
  }
  
  class { 'puppetdb::master::config':
    manage_report_processor => true,
    enable_reports => true,
  }

  class { 'puppetexplorer':
#    puppetdb_servers => [['127.0.0.1'],['/api']],
    require => [
      Class['puppetdb'],
      Class['puppetdb::master::config'],
    ],
  }
  
  service { 'iptables':
    ensure => stopped,
    enable => false,
  }
  
}
