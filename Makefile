current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t bde2020/spark-base:$(current_branch) ./base
	docker build -t bde2020/spark-master:$(current_branch) ./master
	docker build -t bde2020/spark-worker:$(current_branch) ./worker
	docker build -t bde2020/spark-submit:$(current_branch) ./submit

push-testing:
	docker tag bde2020/spark-base:$(current_branch) earthquakesan/spark:base-$(current_branch)
	docker tag bde2020/spark-master:$(current_branch) earthquakesan/spark:master-$(current_branch)
	docker tag bde2020/spark-worker:$(current_branch) earthquakesan/spark:worker-$(current_branch)
	docker tag bde2020/spark-submit:$(current_branch) earthquakesan/spark:submit-$(current_branch)
	docker push earthquakesan/spark:base-$(current_branch)
	docker push earthquakesan/spark:master-$(current_branch)
	docker push earthquakesan/spark:worker-$(current_branch)
	docker push earthquakesan/spark:submit-$(current_branch)

test:
	docker-compose -f docker-compose.yml up -d
	docker logs -f spark-app

test-yarn:
	docker-compose -f docker-compose.yarn.yml up -d
	docker logs -f spark-app
