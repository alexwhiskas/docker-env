# Docker Environment for Local Development

### Files structure
- **docker-compose.yml** files - main entry point which manages list of available services (nginx, php-fpm, mysql, etc.),
you should update it according to used OS, and you also might want to disable https or varnish service (just follow tips in docker-compose.yml file itself, update "ports" configuration, etc.)
- **services** folder - directory with services and their configuration files,
eg: "services/php-fpm/conf" directory stores all *.ini files which used to apply custom configurations and will be mounted to "php-fpm" service container
- **bin** - different useful scripts to generate dump, setup domain, create admin user or simply run bin/magento command
- **diff-files** - used to store files within env folder which related to env but should not be added to VCS

### XDEBUG
- XDEBUG extensions enabled for php by default, just setup server setting in PhpStorm (Settings -> Language & Frameworks -> PHP -> Servers),
  take name from **_COMPOSE_PROJECT_NAME_** variable in .env file, and then configure project path mapping (in container it's usually will be `/var/www/src`

### Tips (_general_)
- you should run all **_bin_** folder scripts from env folder, where your `docker-compose.yml` lives in
- if you need to update configuration for php-fpm, you can add file to `services/php-fpm/conf` folder
and update `services/php-fpm/conf/docker-compose.yml` file (add your file in volumes section)
- if you need **elasticsearch** service, search for _elasticsearch_ in `docker-compose.yml`
- to keep your files after removing service container, but not mount it from/to localhost, you can configure **volumes** in `docker-compose.yml` (search for **magento** in `docker-compose.yml` file)
- to copy-paste files from/to container, use scripts from `./bin/utility/container` folder
(`./bin/utility/container/copy-from.sh php-fpm COPY_FROM_CONTAINER_PATH PASTE_TO_LOCALHOST_PATH`
OR `./bin/utility/container/copy-to.sh php-fpm COPY_FROM_LOCALHOST_PATH PASTE_TO_CONTAINER_PATH`)
- another way of installing dependencies via _composer_ within container inside specific directory:
`./bin/docker/cli.sh -u www-data php-fpm /bin/sh -c "(cd $DIRECTORY && composer install)"`
- if you changed some configuration files, you need to restart services containers with: `./bin/docker/restart.sh`
- if you want to assign new environment variable to service container, which value will be based on variable from general `./.env` file, you should write it in service section in `docker-compose.yml` (ex: check environment section for rabbitmq service here: `services/rabbitmq/docker-compose.yml`)
- if you want to add/change environment variables or mount new directories, you should _hard restart_ environment with `./bin/docker/restart.sh --hard`
- create dump from container: `./bin/utility/mysql/dump-create.sh magento ./diff-files/ dump`
- import dump to container: `./bin/utility/mysql/dump-import.sh magento ./diff-files/dump.sql`
- to use _phpmyadmin_ instead of creating connection in phpstorm - search for _phpmyadmin_ in `docker-compose.yml`

### Tips (_for macOS_)
- you might want to bind only those files, which you work with, to do this, just update "volumes" section of "php-fpm" service with snippet below (you might update it if you need any other folders)
```
#      - ${LOCALHOST_PROJECT_PATH}/app/code:${CONTAINER_PROJECT_PATH}/app/code:delegated
#      - ${LOCALHOST_PROJECT_PATH}/app/design:${CONTAINER_PROJECT_PATH}/app/design:delegated
#      - ${LOCALHOST_PROJECT_PATH}/app/etc:${CONTAINER_PROJECT_PATH}/app/etc:delegated
#      - ${LOCALHOST_PROJECT_PATH}/composer.json:${CONTAINER_PROJECT_PATH}/composer.json:delegated
#      - ${LOCALHOST_PROJECT_PATH}/composer.lock:${CONTAINER_PROJECT_PATH}/composer.lock:delegated
```
- you should check Dockerfile for used php version (in `services/php-fpm` comment/uncomment lines for CPU architecture: **x86** or **arm**)

### Project install

#### _Tip_
- before project install, check variables in .env files search in project by _vars to define_,
the idea is to update these vars values: COMPOSE_PROJECT_NAME, IP_ADDRESS, LOCALHOST_PROJECT_PATH, CONTAINER_PROJECT_PATH, HOST_NAME, DEFAULT_STORE_CODE
- uncomment **_volumes_** section in `docker-compose.yml` to mount project dir into services container,
by default, you should mount project dirs into **_nginx_** and **_php-fpm_** services
- on macOS, you might not want to use _volumes_ feature instead of mounting folders from localhost due to lack of performance
to do so, copy-paste project files to container and then - _install composer dependencies within container and copy-paste files to localhost, or vice versa_

### Clean magento (for self education)
- git clone `git@github.com:alexwhiskas/docker-env.git` env
- in `docker-compose.yml` file update `ports` sections, and uncomment **_elasticsearch_** service if needed
- generate ssl certificate if needed `./bin/utility/ssl-proxy/generate-certificate.sh $DOMAIN_NAME`
- run `./bin/docker/build.sh`, `docker-compose up -d` and then `docker-compose ps` to see if everything processed OK
- run `./bin/composer/setup-auth.sh $PUBLIC_KEY $PRIVATE_KEY`)
- run `./bin/utility/container/fix-ownership.sh`
- run `./bin/magento/setup/download.sh $EDITION $VERSION $FOLDER` (ex: `./bin/magento/setup/download.sh community 2.3.7-p2 /var/www/src`)
- proceed with DON'T HAVE MYSQL DUMP step

### Existing project install flow
- `(cd ~/projects/ && git clone $REMOTE_ADDR $PROJECT_DIR)`
- `cd ~/projects/$PROJECT_DIR`
- `git config core.fileMode false` (setup VCS to not track any files permissions changes)
- `git clone git@github.com:alexwhiskas/docker-env.git env`
- you may want to create or copy-paste auth.json to install dependencies with composer _(check php-fpm Dockerfile if you need to change composer version)_
- in `docker-compose.yml` file update `ports` sections, and uncomment **_elasticsearch_** service if needed
- generate ssl certificate if needed `./bin/utility/ssl-proxy/generate-certificate.sh $DOMAIN_NAME`
- run `./bin/docker/build.sh`, `docker-compose up -d` and then `docker-compose ps` to see if everything processed OK
- run `./bin/utility/container/fix-ownership.sh`
- install dependencies with composer (`composer install --ignore-platform-reqs`) or run `./bin/composer.sh install`

---
_if you have mysql dump_
- copy-paste env.php, mysql dump file, media archive
- run `./bin/utility/mysql/dump-import.sh dbname dump_file_path` _(or dump-import-archived.sh script)_
- run `./bin/magento.sh indexer:reset && ./bin/magento.sh indexer:reindex`
---
_if you don't have mysql dump_
- install magento with script: `./bin/magento/setup/install.sh DOMAIN IP PORT LOCALE CURRENCY TIMEZONE AMQP_USER AMQP_PASSWORD MAGENTO_INSTALLATION_DIR`,
  `AMQP_USER` and `AMQP_PASSWORD` can be taken from .env file variable `COMPOSE_PROJECT_NAME`
  (example for project name **magento** and magento sources in `/var/www/src` directory: `./bin/magento/setup/install.sh m2.local.magento 127.0.0.1 ::1 en_AU AUD Australia/Melbourne magento magento /var/www/src`)
- check if everything ok with project installation `./bin/magento.sh`
---

- setup domain with `./bin/magento/setup/domain.sh $IP_ADDRESS $DOMAIN --no-port` (port will be used only for macOS)
