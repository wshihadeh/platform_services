# frozen_string_literal: true

server '127.0.0.1', user: 'shihadeh',
                         roles: %w[
                           mysql
                           nginx
                           ldap
                           registry
                           swarm_manager
                         ]

set :shared, network: fetch(:network)
set (:deploy_to) { '/Users/shihadeh/personal/swarm_orcs_deployments/platform_services' }
set (:config_path) { "#{fetch(:deploy_to)}/configs" }

set :mysql,
    stack_name: 'mysql',
    mysql_docker_image: 'mysql/mysql-server',
    mysql_docker_image_tag: '5.7',
    mysql_volume: "#{fetch(:deploy_to)}/mysql"

set :nginx,
    stack_name: 'nginx',
    nginx_docker_image: 'wshihadeh/nginx',
    nginx_docker_image_tag: 'latest',
    nginx_replica_count: 1,
    port_http: '80',
    port_https: '443'

set :ldap,
    stack_name: 'ldap',
    ldap_docker_image: 'osixia/openldap',
    ldap_docker_image_tag: '1.2.4',
    ldap_volume: "#{fetch(:deploy_to)}/ldap",
    ldap_admin_password: 'test1234',
    ldap_domain: 'shihadeh.intern',
    ldap_organisation: 'Al Inc.',
    ldap_base_dn: 'dc=shihadeh,dc=intern',
    ldap_admin_docker_image: 'osixia/phpldapadmin',
    ldap_admin_docker_image_tag: '0.7.2'

set :registry,
    stack_name: 'registry',
    registry_storage: 'filesystem',
    registry_storage_delete_enabled: 'true',
    registry_storage_filesystem_rootdirectory: '/var/lib/registry',
    registry_volume: "#{fetch(:deploy_to)}/registry",
    config_path: fetch(:config_path)
