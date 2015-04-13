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

define append_if_no_such_line($file,$line) {
  exec { "/bin/echo '${line}' >> '${file}'":
    unless => "/bin/grep -Fx '${line}' '${file}'",
  }
}

define replace_machting_line($file,$match,$replace) {
  exec { "/usr/bin/ruby -i -p -e 'sub(%r{$match}, \"$replace\")' ${file}":
    onlyif => "/bin/grep -E '${match}' ${file}",
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

node 'cookbook' {
  tag('big-server')
  include memcached
  include puppet
  include admin::ntp
  include admin::rsyncdconf

  $ipaddresses = ['192.168.0.1',
                  '158.43.128.1',
                  '10.0.75.207']
  file { '/tmp/addresslist.txt': 
    content => template('admin/addresslist.erb')
  }

  $mysql_password = 'test'
  file { '/usr/local/bin/backup-mysql':
    content => template('admin/backup-mysql.sh.erb'),
    mode    => '0755',
  }

  augeas { 'enable-ip-forwarding':
    context => '/files/etc/sysctl.conf',
    changes => ['set net.ipv4.ip_forward 1 '],
  }

  file { '/etc/rsyncd.d/myapp.conf':
    ensure  => present,
    source  => 'puppet:///modules/admin/myapp.rsync',
    require => File['/etc/rsyncd.d'],
    notify  => Exec['update-rsyncd.conf'],
  }    

  if tagged('big-server') {
    notify { 'Big server detected. Adding extra workload': }
  }
  
  if tagged('admin::ntp') {
    notify { 'This node is running NTP': }
  }
  
  if tagged('admin') {
    notify { 'This node includes at least one class from the admin module': }
  }

#  append_if_no_such_line { 'enable-ip-contrack':
#    file => '/etc/modules',
#    line => 'ip_conntrack',
#  }

  replace_machting_line { 'disable-ip-conntrack':
    file    => '/etc/modules',
    match   => '^ip_conntrack',
    replace => '#ip_conntrack',
  }
}
