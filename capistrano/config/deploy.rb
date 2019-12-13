# config valid only for current version of Capistrano
lock "3.8.0"
require "capistrano/swarm_orca/set_global_config"

# Overwrite swarm_orca global vars

set :fork, "wshihadeh"
set (:network) { "platform" }

#Overwite gem global vars
set (:repo_url) { ENV["REPO_URL"] || "git@github.com:#{ENV.fetch('FORK', fetch(:fork))}/platform_services.git" }

set :keep_releases, 3
set (:application) { "platform_services" }
#set (:deploy_to) { "/home/deploy/orca" }
#set :pty, true

set (:service_stacks) { %w(mysql) }
set (:service_stacks_with_build_image) { %w(nginx) }
set (:db_apps_stacks_mapping), {}

set (:elasticsearch_apps) { [] }
#set the path containing docker command
#set (:docker_path) { "" }
set (:docker_erb_templates) { true }
#set (:docker_cleanup) { %w(yes 1 true).include? ENV.fetch("PRUNE", 'true') }
#set (:auto_image_build){ %w(yes 1 true).include? ENV.fetch("BUILD_IMAGE", 'true') }

require "capistrano/swarm_orca/deploy"
require "capistrano/swarm_orca/docker"
