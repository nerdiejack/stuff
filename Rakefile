REPO = 'git@github.com:nerdiejack/stuff.git'
SSH = 'ssh -p 32 -A -i /root/.ssh/id_rsa -l root'

desc "Bootstrap Puppet on ENV['CLIENT'] with 
	hostname ENV['HOSTNAME']"
task :bootstrap do
	client = ENV['CLIENT']
	hostname = ENV['HOSTNAME'] || client
	commands = <<BOOTSTRAP
hostname #{hostname} && \
su -c 'echo #{hostname} >/etc/hostname' && \
wget http://apt.puppetlabs.com/puppetlabs-release-wheezy.deb && \
dpkg -i puppetlabs-release-wheezy.deb && \
apt-get update && apt-get install -y git puppet && \
git clone "#{REPO} puppet && \
puppet apply --modulepath=/root/puppet/modules /root/puppet/manifests/nodes.pp
BOOTSTAP
	sh "#{SSH} #{client} '#{commands}'"
end

desc "Run Puppet on ENV['CLIENT']"
task :apply do
	client = ENV['CLIENT']
	sh "git push"
	sh "#{SSH} #{client} pull-updates"
end
