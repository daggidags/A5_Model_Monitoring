# Makefile

# Names
API_IMAGE = sentiment-api
MONITOR_IMAGE = sentiment-monitor
API_CONTAINER = sentiment-container
MONITOR_CONTAINER = sentiment-monitoring-container
NETWORK = sentiment-net
VOLUME = sentiment-logs

.PHONY: build run clean stop logs

build:
	docker build -t $(API_IMAGE) ./api
	docker build -t $(MONITOR_IMAGE) ./monitoring

run:
	docker network create $(NETWORK) || true
	docker volume create $(VOLUME) || true
	docker run -d --name $(API_CONTAINER) --network $(NETWORK) -v $(VOLUME):/logs -p 8000:8000 $(API_IMAGE)
	docker run -d --name $(MONITOR_CONTAINER) --network $(NETWORK) -v $(VOLUME):/logs -p 8501:8501 $(MONITOR_IMAGE)

stop:
	docker rm -f $(API_CONTAINER) $(MONITOR_CONTAINER) || true

clean: stop
	docker network rm $(NETWORK) || true
	docker volume rm $(VOLUME) || true
	docker rmi $(API_IMAGE) $(MONITOR_IMAGE) || true

logs:
	docker logs $(API_CONTAINER)
