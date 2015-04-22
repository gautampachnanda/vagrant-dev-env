class java {

  package { "python-software-properties":
    require => Exec['apt-update'],
    ensure => installed
  }

  exec { 'add-webupd8-key':
    command => 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886',
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
  }

  exec { 'apt-update':
    command => 'sudo apt-get update',
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
  }

  exec { "add-apt-repository-oracle":
    command => "sudo add-apt-repository -y ppa:webupd8team/java",
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
    require => [Exec["add-webupd8-key"],Package["python-software-properties"]],
#    notify => Exec["apt-update"]
  }

  exec {
    'set-licence-selected':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections';

    'set-licence-seen':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections';
  }

  package { 'oracle-java7-installer':
#    ensure => "7u40-0~webupd8~0",
    ensure => installed,
    require => [Exec['add-apt-repository-oracle'], Exec['apt-update'], Exec['set-licence-selected'], Exec['set-licence-seen']],
  }
}

include java
