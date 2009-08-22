set :application, "quest-for-life"
set :repository,  "git@github.com:railsrumble/rr09-team-72.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

set :scm, :git

role :app, "69.164.192.31"
role :web, "69.164.192.31"
role :db,  "69.164.192.31", :primary => true