#!/bin/bash -e

mkdir -p ~/backups
for volume in akaunting-data akaunting-modules akaunting-db; do
	docker run --rm -v $volume:/volume -v ~/backups:/backups alpine tar cvzf /backups/$volume-$(date +%Y-%m-%d).tgz -C /volume ./
done