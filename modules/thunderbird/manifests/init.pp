#Manage Thunderbird/icedove
class thunderbird {
  if $::operatingsystem == 'Debian' {
    package { 'icedove':
      ensure => installed,
    }
  } else {
      package { 'thunderbird':
        ensure => installed,
      }
  }
}      
