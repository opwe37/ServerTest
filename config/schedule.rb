# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :environment, 'development'
set :output, {:error => "/home/ubuntu/workspace/log/cron_error_log.log", :standard => "/home/ubuntu/workspace/log/cron_log.log" } 
set :job_template, "/bin/bash -i -c ':job'"
env :PATH, ENV['PATH']

every 5.minutes  do
    runner 'Festival.end_festival_destroy', :environment => 'development'
end