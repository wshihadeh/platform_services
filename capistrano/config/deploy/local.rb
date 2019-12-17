# frozen_string_literal: true

server '127.0.0.1', user: 'shihadeh',
                         roles: %w[
                           mysql
                           nginx
                           ldap
                           registry
                           portus
                           clair
                           swarm_manager
                         ]

set :shared,
     network: fetch(:network),
     registry_domain: 'hub.shihadeh.intern',
     registry_ip:     '192.168.178.26'

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
    nginx_docker_image_tag: 'v2',
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

set :portus,
    stack_name: 'portus',
    portus_machine_fqdn_value: 'hub.shihadeh.intern',
    portus_db_host: 'mysql_server',
    portus_db_database: 'portus_production',
    portus_db_username: 'root',
    portus_db_password: 'dummy',
    portus_db_pool: '5',
    config_prefix: 'PORTUS',
    config_path: fetch(:config_path),
    portus_secret_key_base: '41080f4bf7415093858fdc871b873a668a5e2eb71d07bee3c43524fe9b6a63a2605da513abf7e8a6c56504586cf1a681f4eeb3f7dbea50ebb6da51bd5be1791b',
    portus_key_path: '/certificates/hub.shihadeh.intern.key',
    portus_password: 'test123',
    portus_check_ssl_usage_enabled: 'false',
    rails_serve_static_files: 'true',
    portus_ldap_enabled: 'true',
    portus_ldap_hostname: 'ldap_server',
    portus_ldap_port: '389',
    portus_ldap_uid: 'givenName',
    portus_ldap_base: 'dc=shihadeh,dc=intern',
    portus_ldap_filter: '',
    portus_ldap_authentication_enabled: 'true',
    portus_ldap_authentication_bind_dn: 'cn=admin,dc=shihadeh,dc=intern',
    portus_ldap_authentication_password: 'test1234',
    portus_ldap_encryption_method: 'plain',
    portus_delete_enabled: 'true',
    portus_delete_contributors: 'true',
    portus_delete_garbage_collector_enabled: 'false',
    portus_delete_garbage_collector_older_than: '60',
    portus_delete_garbage_collector_keep_latest: '5',
    portus_delete_garbage_collector_tag: 'featuer*',
    portus_pagination_limit: '10',
    portus_pagination_before_after: '2',
    PORTUS_SECURITY_CLAIR_SERVER: 'http://clair_server:6060'

set :clair,
    stack_name: 'clair',
    postgres_docker_image: 'postgres',
    postgres_docker_image_tag: 'alpine',
    postgres_user: 'postgres',
    postgres_password: 'clair12postgres',
    postgres_db: 'clair_db',
    clair_docker_image: 'wshihadeh/clair',
    clair_docker_image_tag: 'v0.1',
    postgres_database_url: 'postgresql://postgres:clair12postgres@clair_postgres:5432/clair_db?sslmode=disable'
