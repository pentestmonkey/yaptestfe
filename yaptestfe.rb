#!/usr/bin/env ruby
require 'optparse'

OPTIONS = {
  :username => "yaptest_user",
  :password => "pass", # doesn't matter if local trust is configured
  :port     => 5432,
  :ip       => "127.0.0.1",
  :dbname   => nil,
  :webport  => 3000,
  :webip    => "127.0.0.1",
  :type     => "postgresql",
  :wizard   => 0
}

ARGV.options do |opts|
  script_name = File.basename($0)
  dir_name = File.dirname($0)
  Dir.chdir(dir_name)
  opts.banner = "Usage: ruby #{script_name} -d dbname [options]"

  opts.separator ""

  opts.on("-d", "--dbname=name", String,
          "Database name used by Yaptest.  A database name is MANDATORY.",
          "Default: none") { |v| OPTIONS[:dbname] = v }
  opts.on("-i", "--ip=ip", String,
          "IP address of backend database.",
          "Default: #{OPTIONS[:ip]}") { |v| OPTIONS[:ip] = v }
  opts.on("-W", "--wizard", String,
          "Interactive wizard to configure YaptestFE.",
          "Default: off (use cmd line)") { |v| OPTIONS[:wizard] = v }
  opts.on("-p", "--port=port", Integer,
          "TCP port for backend database.",
          "Default: #{OPTIONS[:port]}") { |v| OPTIONS[:port] = v }
  opts.on("-u", "--username=user", String,
          "Username for backend database.",
          "Default: yaptest_user") { |v| OPTIONS[:username] = v }
  opts.on("-P", "--password=pwd", String,
          "Password for backend database (not needed for postgres local trust)",
          "Default: #{OPTIONS[:password]}") { |v| OPTIONS[:password] = v }
  opts.on("-t", "--type=type", "Type of databse backend ('postgresql', 'mysql', etc.)",
          "Default: #{OPTIONS[:type]}") { |v| OPTIONS[:type] = v}
  opts.on("-w", "--webport=port", Integer,
          "TCP port for web server to bind to.",
          "Default: #{OPTIONS[:webport]}") { |v| OPTIONS[:webport] = v }
  opts.on("-I", "--webip=ip", String,
          "IP Address for web server to bind to.",
          "Default: #{OPTIONS[:webip]}") { |v| OPTIONS[:webip] = v }

  opts.separator ""

  opts.on("-h", "--help",
          "Show this help message.") { puts opts; exit }

  opts.parse!
end

if OPTIONS[:wizard] != 0
	puts "*** Configuring YaptestFE parameters using Wizard ***"
	printf "Database name: " % OPTIONS[:dbname]
	i = STDIN.readline.gsub(/\n/, "")
	if i =~ /^\s*$/
		puts "ERROR: Database name can't be blank.  Use \\l in psql to list db names"
		exit 1
	end
	OPTIONS[:dbname] = i
	
	printf "Bind Webserver to IP [%s]: " % OPTIONS[:webip]
	i = STDIN.readline.gsub(/\n/, "")
	if not i =~ /^\s*$/
		OPTIONS[:webip] = i
	end
	
	printf "Webserver Port [%s]: " % OPTIONS[:webport]
	i = STDIN.readline.gsub(/\n/, "")
	if not i =~ /^\s*$/
		OPTIONS[:webport] = i
	end
	
	printf "Database username [%s]: " % OPTIONS[:username]
	i = STDIN.readline.gsub(/\n/, "")
	if not i =~ /^\s*$/
		OPTIONS[:username] = i
	end
	
	printf "Database password [%s]: " % OPTIONS[:password]
	i = STDIN.readline.gsub(/\n/, "")
	if not i =~ /^\s*$/
		OPTIONS[:password] = i
	end
	
	printf "Database port [%s]: " % OPTIONS[:port]
	i = STDIN.readline.gsub(/\n/, "")
	if not i =~ /^\s*$/
		OPTIONS[:port] = i
	end
	
	printf "Database IP [%s]: " % OPTIONS[:ip]
	i = STDIN.readline.gsub(/\n/, "")
	if not i =~ /^\s*$/
		OPTIONS[:ip] = i
	end
	
end

if OPTIONS[:dbname].nil?
	puts "ERROR: Must specify a database name with -d.  Use -h for help."
	exit 1
end

ENV["YAPTESTFE_DBPORT"] = OPTIONS[:port].to_s
ENV["YAPTESTFE_DBIP"] = OPTIONS[:ip]
ENV["YAPTESTFE_DBUSER"] = OPTIONS[:username]
ENV["YAPTESTFE_DBPASS"] = OPTIONS[:password]
ENV["YAPTESTFE_DBNAME"] = OPTIONS[:dbname]
ENV["YAPTESTFE_DBTYPE"] = OPTIONS[:type]

system("script/server -e production -b #{OPTIONS[:webip]} -p #{OPTIONS[:webport]}")
