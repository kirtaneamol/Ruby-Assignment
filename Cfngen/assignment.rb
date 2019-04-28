require 'bundler/inline'
gemfile true do
 source 'http://rubygems.org'
 gem 'oj'
end

#Gem dependencies
require 'oj'
require 'optparse'

#Load modules ruby files from same folder path
$LOAD_PATH << '.'
require 'resources'
require 'stack'

#load modules 
include A
include B

#Parse options passed via command line
options = {}
optparse = OptionParser.new do|opts|

  # Define the options here to be passed via command line
  options[:instances] = 1 #Default value
  opts.on( '-v', '--instances inst', 'Number of instances' ) do|inst|
  options[:instances] = inst
  end
  options[:instancetype] = 't2.micro' #Default value
  opts.on( '-q', '--instance-type intyp', 'Instance type' ) do |intyp| 
  options[:instancetype] = intyp
  end
  options[:allowsshfrom] = '0.0.0.0/0' #Default value
  opts.on( '-a', '--allow-ssh-from ips', 'Allowed IP CIDR' ) do|ips|
  options[:allowsshfrom] = ips
  end
  options[:imageid] = 'ami-b97a12ce' #Default value
  opts.on( '-m', '--imageid img', 'Allowed IP CIDR' ) do|img|
  options[:imageid] = img
  end
  options[:fromport] = '22' #Default value
  opts.on( '-o', '--fromport fmp', 'Allowed IP CIDR' ) do|fmp|
  options[:fromport] = fmp
  end
  options[:toport] = '22' #Default value
  opts.on( '-l', '--toport top', 'Allowed IP CIDR' ) do|top|
  options[:toport] = top
  end
  options[:ipprotocol] = '22' #Default value
  opts.on( '-l', '--ipprotocol iprot', 'Allowed IP CIDR' ) do|iprot|
  options[:ipprotocol] = iprot
  end
end
optparse.parse!

#Generate stack cloud formation template
stack1 = Stack.new(options)

#Generate JSON format template
puts Oj::dump stack1, :indent => 2, :mode => :custom