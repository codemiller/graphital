require 'rubygems'
require 'daemons'

current_dir = Dir.pwd
options = {
  :log_dir => current_dir,
  :log_output => true
}
Daemons.run('graphital.rb', options)
