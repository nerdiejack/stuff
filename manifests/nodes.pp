if $::operatingsystem in [ 'Ubuntu', 'Debian' ] {
  notify {  'Debian-type operating system detected': }
} elsif $::operatingssytem in [ 'Redbat', 'Fedora', 'SuSE', 'CentOS' ] {
  notify { 'RedHat-type operating system detected': }
} else {
  notify { 'Some other operating system detcted': }
}

$class_c = regsubst($::ipaddress, '(.*)\..*', '\1.0')
  notify { "The network part of ${::ipaddress} is ${class_c}": }

define tmpfile() {
  file { "/tmp/${name}":
    content => "Hello, world\n",
  }
}

tmpfile { ['a', 'b', 'c']: }

node 'cookbook2' { 
	include puppet
	include admin::ntp
}

node 'cookbook3' {
  include puppet
  include admin::ntp
}

node 'cookbook' inherits 'cookbook3' {
  if tagged ('cookbook') {
    notify { 'this will succeed': }
  }
  if tagged ('cookbook3') {
    notify { 'so will this': }
  }
  include memcached
  include puppet
  include admin::ntp
}
