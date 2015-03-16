SSH = 'ssh -p 32 -A -i /root/.ssh/id_rsa -l root'

desc "Run Puppet on ENV['CLIENT']"
task :apply do
	client = ENV['CLIENT']
	sh "git push"
	sh "#{SSH} #{client} pull-updates"
end
