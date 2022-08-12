#!/usr/bin/env ruby
require "optparse"

OPTS={
  :n => 100,
  :len_id => 8,
  :len_pass => 10,
}
opt = OptionParser.new

opt.on("-n COUNT", "--num=NUM") {|v|
  OPTS[:n] = v.to_i
}
opt.on("-l LENGTH_OF_ID", "--len-of-id==VAL") {|v|
  OPTS[:len_id] = v.to_i
}
opt.on("-L LENGTH_OF_PASS", "--Length-of-pass==VAL") {|v|
  OPTS[:len_pass] = v.to_i
}

(class<<self;self;end).module_eval do
  define_method(:usage) do |msg|
    puts opt.to_s
    puts "error: #{msg}" if msg
    exit 1
  end
end

begin
  rest = opt.parse(ARGV)
  # XXX: this forbids option-less argument
  if rest.length != 0
    usage nil
  end
rescue
  usage $!.to_s
end

$debug = false

def dp str
  if $debug
    p str
  end
end

def pwgen len=8
  io = IO.popen("pwgen #{len} 1")
  data = io.gets
  io.close
  data.strip
end

OPTS[:n].times do
  id = pwgen(OPTS[:len_id])
  pass = pwgen(OPTS[:len_pass])
  puts "#{id},#{pass}"
end
