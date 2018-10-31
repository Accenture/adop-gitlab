# Supported tags and respective Dockerfile links
* [0.1.0](accenture/adop-gitlab:0.1.0)

# What is adop-GitLab?
adop-gitlab is a wrapper for the official GitLab image. It has primarily been built to extended configuration and integrate with the ADOP platform. GitLab is a git repository tool for source code versioning and management. 

# How to use this image
If you plan to run only Gitlab please use [offical Gitlab image](https://hub.docker.com/r/gitlab/gitlab-ce/). This image you need to run with [adop-docker-compose](https://github.com/Accenture/adop-docker-compose).

The following assumes that PostgreSQL, Redis and OpenLDAP are running.
The following command will run adop-gitlab and connect it to PostgreSQL, Redis and OpenLDAP
With [Docker compose](https://docs.docker.com/compose/) you can easily configure, install, and upgrade your Docker-based GitLab installation.
1. [Install](https://docs.docker.com/compose/install/) Docker Compose
2. Create a `docker-compose.yml` file
```
gitlab:
  container_name: gitlab
  restart: always
  image: accenture/adop-gitlab:VERSION
  expose:
    - "80"
    - "22"
  environment:
    INITIAL_ADMIN_USER: ${INITIAL_ADMIN_USER}
    INITIAL_ADMIN_PASSWORD: ${INITIAL_ADMIN_PASSWORD}
    JENKINS_USER: ${JENKINS_USER}
    JENKINS_PASSWORD: ${JENKINS_PASSWORD} 
    GITLAB_OMNIBUS_CONFIG: |
     external_url "http://<local-ip>/gitlab"
     postgresql['enable'] = false
     gitlab_rails['db_username'] = "gitlab"
     gitlab_rails['db_password'] = "gitlab"
     gitlab_rails['db_host'] = "gitlab-postgresql"
     gitlab_rails['db_port'] = "5432"
     gitlab_rails['db_database'] = "gitlabhq-production"
     gitlab_rails['db_adapter'] = 'postgresql'
     gitlab_rails['db_encoding'] = 'utf8'
     # Redis Configuration
     redis['enable'] = false
     gitlab_rails['redis_host'] = 'gitlab-redis'
     gitlab_rails['redis_port'] = '6379'
     # LDAP Configuration
     gitlab_rails['ldap_enabled'] = true
     gitlab_rails['ldap_servers'] = YAML.load <<-'EOS'
       main:
         label: 'LDAP'
         host: 'ldap'
         port: 389
         uid: 'uid'
         method: 'plain'
         bind_dn: '<ldap-manager-dn>'
         password: '<ldap-password>'
         active_directory: true
         allow_username_or_email_login: false
         block_auto_created_users: false
         base: '<ldap-full-domain>'
         signin_enabled: false
     EOS
```

Runtime configuration can be provided using environment variable:

* GITLAB_OMNIBUS_CONFIG, This variable can contain any gitlab.rb setting and will be evaluated before loading the container’s gitlab.rb file. That way you can easily configure GitLab’s external URL, make any database configuration. [Omnibus settings.](https://docs.gitlab.com/omnibus/settings/README.html)
* INITIAL_ADMIN_USER, the username for the admin user.
* INITIAL_ADMIN_PASSWORD, the password for the initial admin user.
* JENKINS_USER, the username Jenkins will use to connect to Gitlab. Default to Jenkins.
* JENKINS_PASSWORD, the password Jenkins will use to connect to Gitlab. Default to jenkins.

# License
Please view [licence information](LICENSES.md) for the software contained on this image.

# User feedback

## Documentation
Documentation is available in the [GitLab documentation page](https://docs.gitlab.com/omnibus/docker/#configure-gitlab).

## Issues
If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/Accenture/adop-gitlab/issues).

## Contribute
You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/Accenture/adop-gitlab/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.