node master {

  include puppetdb
  include puppetdb::master::config

  class { 'puppetexplorer':
    require => [
      Class['puppetdb'],
      Class['puppetdb::master::config'],
    ],
  }

}
