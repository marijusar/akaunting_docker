# Overview

This repository includes instructions and utilities for building an official Akaunting Docker image and deploying in to your local network.

# Dependencies

- Docker
- Docker-compose
- Make

# Setting up

Make sure you have all the required dependencies.

## Environment variables

```bash
$ cp env/db.env.example env/db.env
$ vi env/db.env # and set things
$ cp env/run.env.example env/run.env
$ vi env/run.env # and set things
```

- `APP_URL` - if you're planning to run the images on a local network, just leave `http:localhost:8080`. If the application will be exposed to the external users add the domain under which the application will be accessed;
- `MYSQL_PASSWORD` in `db.env` and `DB_PASSWORD` in `run.env` - make sure they match;
- `COMPANY_EMAIL`, `COMPANY_NAME`, `ADMIN_EMAIL`, `ADMIN_PASSWORD` - you can modify these variables as you like.

## Running containers for the first time

Run

```bash
$ make setup
```

This might take a while to build your container images on a new machine. The command will seed initial data including company and admin data that you passed as enviroment variables.

You can run

```bash
$ make logs
```

If you can see Apache logs, the server has been started and it can be accessed on port `:8080`.

Complete the setup wizard in the application.

Restart the application in regular mode.

```bash
$ make stop
$ make start
```

# Migrating to other machine

## Creating backups

Make sure that user creating the backup can change permissions and make scripts executable. To build backups run,

```bash
$ make backup
```

This will create `.tgz` files for all 3 volumes in `~/backup`.

## Seeding backups in the new machine

Make sure you have all required dependencies.

Create `~/backup` folder and move the backups there.

To change which backups are seeded, you can change `backup` variable in the `./files/seed_volumes.sh`.

Before seeding data make sure that all volumes have `external:true` flag in `docker-compose.yml`.

```bash
volumes:
  akaunting-data:
    external:
      true
  akaunting-modules:
    external:
      true
  akaunting-db:
    external:
      true
```

Make sure that user seeding the backup can change permissions and make scripts executable. To seed data run

```bash
$ make seed
```

Start docker container instances

```bash
$ make start
```
