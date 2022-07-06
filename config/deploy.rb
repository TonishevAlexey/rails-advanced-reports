# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "rails-advanced-reports"
set :repo_url, "git@github.com:TonishevAlexey/rails-advanced-reports.git"


# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/rails-advanced-reports"
set :deploy_user, 'deploy'
set :pty, false

# Default value for :linked_files is []
append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", 'storage'


after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

