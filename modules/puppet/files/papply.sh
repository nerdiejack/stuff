#!/bin/sh
puppet apply /root/puppet/manifests/nodes.pp --modulepath=/root/puppet/modules/  --hiera_config=/root/puppet/data/hiera.yaml $*
