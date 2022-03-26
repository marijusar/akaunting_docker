setup: 
	AKAUNTING_SETUP=true docker-compose up -d
stop: 
	docker-compose down
start:
	docker-compose up -d
backup:
	chmod +x ./files/backup.sh && ./files/backup.sh

seed: 
	chmod +x ./files/seed_volumes.sh && ./files/seed_volumes.sh

logs:  
	docker logs --details akaunting

.PHONY: setup stop start backup seed logs