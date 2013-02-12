#!/usr/bin/ruby
# Graphital modified for use on OpenShift, with stats to be pulled rather than pushed
# Modified by Katie Miller (katie@codemiller.com)

begin
  graphitalDir = ENV['OPENSHIFT_DATA_DIR'] + '/graphital'
  load "#{graphitalDir}/graphital.conf" 
rescue LoadError
  begin
    load "#{graphitalDir}/graphital.conf.eg"
  end
end

require 'timeout'

def vitals
  vitals = Array.new
  Dir.foreach("#{$PATH}") do |item|
    next if item == '.' or item == '..'
    vitals << Thread.new{ Thread.current[:output] = run_vital(item) }
  end
  vitals
end

def run_vital(item)
  vital = nil
  name = item.split('.').first
  status = Timeout::timeout($INTERVAL) {
    vital = `#{$PATH}/#{item}`.split("\n")
    vital = name + "." + vital.join("\n#{name}.")
  }
  vital
end

def vital_output(dir, basefilename)
  time = Time.now.to_i.to_s
  output = ''
  vitals.each do |vital|
    vital.join
    vital[:output].split("\n").each do |vital|
      output += "#{$PREFIX}.#{vital} #{time}\n"
    end
  end
  filename = "#{basefilename}.#{time}"
  File.open("#{dir}/#{filename}", 'w') { |file| file.write(output) }
end

loop {
  output = Thread.new{vital_output($OUTPUT_DIR, $BASE_FILENAME)} 
  sleep $INTERVAL;
}

