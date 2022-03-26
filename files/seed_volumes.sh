#!/bin/bash -e

backup=2022-03-26
for volume in akaunting-data akaunting-modules akaunting-db; do
	docker run --rm -v $volume:/volume -v ~/backups:/backups alpine sh -c "rm -rf /volume/* /volume/..?* /volume/.[!.]* ; tar xvzf /backups/$volume-$backup.tgz -C /volume"
done