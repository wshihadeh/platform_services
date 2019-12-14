# Orca
- A Template project for deploying services to a docker swarm cluster. This template includes the deployment stakes for the following services.

  * Nginx
  * MySql
  * Registry
  * Ldap
  * portus

# Deployment Steps
  - Prepare your deployment stage file under `config/deploy/${your_stage_name}.rb`. You can duplicate the `template_stage` and replace all the necessary configurations.
  - Upload deployment scripts to the swarm manager server

    ```sh
    cd capistrano
    bundle exec cap ${your_stage_name} deploy:setup
    ```


- Deploy services/applications individually

  ```sh
  cd capistrano
  bundle exec cap ${your_stage_name} deploy:${service_name}
  ```

- Deploy all services

  ```sh
  cd capistrano
  bundle exec cap ${your_stage_name} deploy:all
  ```

- Deploy subset of the defined services
  ```
  export DEPLOYED_STACKS='nginx mysql'
  export FORK=wshihadeh
  bundle exec cap ${stage} deploy:auto
  ```

- Check Stage status

  ```
  bundle exec cap ${your_stage_name} docker:deploy:info
  ```


- Stop a given stack

  ```
  bundle exec cap ${your_stage_name} docker:stop:${service_name}
  ```
