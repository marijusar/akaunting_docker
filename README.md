## Usage

```shell
git clone https://github.com/akaunting/docker
cd docker
cp env/db.env.example env/db.env
vi env/db.env # and set things
cp env/run.env.example env/run.env
vi env/run.env # and set things

AKAUNTING_SETUP=true docker-compose up -d
```

Then head to HTTP at port 8080 on the docker-compose host and finish configuring your Akaunting company through the interactive wizard.

After setup is complete, bring the containers down before bringing them back up without the setup variable.

```shell
docker-compose down
docker-compose up -d
```

## Backup and restore

You could use something like the following commands to make backups for your deployment:

```shell
mkdir -p ~/backups
for volume in akaunting-data akaunting-modules akaunting-db; do
    docker run --rm -v $volume:/volume -v ~/backups:/backups alpine tar cvzf /backups/$volume-$(date +%Y-%m-%d).tgz -C /volume ./
done
```

In order to restore those backups, you would run something like:

```shell
backup=2021-01-26 # you should select the backup you want to restore here
for volume in akaunting-data akaunting-modules akaunting-db; do
    docker run --rm -v $volume:/volume -v ~/backups:/backups alpine sh -c "rm -rf /volume/* /volume/..?* /volume/.[!.]* ; tar xvzf /backups/$volume-$backup.tgz -C /volume"
done
```
