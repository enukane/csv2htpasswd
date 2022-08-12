
CSVPATH=ARGV.shift
TARGETPATH=ARGV.shift

if CSVPATH.nil? or CSVPATH.empty? or TARGETPATH.nil? or TARGETPATH.empty?
  puts "./csv_to_htpasswd.rb <CSVPATH> <TARGET_HTPASSWD>"
  exit(1)
end


list = []
File.open(CSVPATH, "r") do |f|
  while line = f.gets
    id, pass = line.split(",").map{|elm| elm.strip}
    cmd = "sudo htpasswd -b #{TARGETPATH} #{id} #{pass}"
    system(cmd)
  end
end
