# frozen_string_literal: true

server '127.0.0.1', user: '${USER}',
                         roles: %w[
                           mysql
                           nginx
                           swarm_manager
                         ]

set :shared, network: fetch(:network)
set (:deploy_to) { '/Users/shihadeh/personal/swarm_orcs_deployments/platform_services' }

set :mysql,
    stack_name: 'mysql',
    mysql_docker_image: 'mysql/mysql-server',
    mysql_docker_image_tag: '5.7',
    mysql_volume: "#{fetch(:deploy_to)}/mysql"

set :nginx,
    stack_name: 'nginx',
    nginx_docker_image: 'nginx',
    nginx_docker_image_tag: 'latest',
    nginx_replica_count: 1,
    port_http: '80',
    port_https: '443'
