# config valid for current version and patch releases of Capistrano
lock "~> 3.14.0"

set :application, 'time_to_answer'              # Nome da sua aplicação          
set :repo_url, 'https://github.com/helio-diniz/time_to_answer.git'    # Repositório git do seu projeto

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/time_to_answer"

# Default value for :format is :airbrussh.
# Deixa colorido o log da aplicação quando está sendo levantada
set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"
append :linked_files, "config/database.yml", "config/master.key"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, "storage", "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# No momento que enviar, mostra erro que acontecer com nível de debug
set :log_level, :debug

# Add or adjust default_env to append .npm-packages to $PATH:
set :default_env, {
   PATH: '$HOME/.npm/:$PATH',
   NODE_ENVIRONMENT: 'production'
}