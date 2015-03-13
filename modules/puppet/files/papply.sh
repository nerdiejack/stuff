#!/bin/sh
puppet apply /root/puppet/manifests/nodes.pp --modulepath=/root/puppet/modules/ $*
