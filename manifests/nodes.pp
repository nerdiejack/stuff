node 'cookbook2', 'cookbook3' { 
	include puppet
}

node 'cookbook' {
  include memcached
  include puppet
}
