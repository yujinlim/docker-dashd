.PHONY: build
build:
	docker build -t neuroware/dashd .

.PHONY: deploy
deploy: login build
	docker tag neuroware/dashd neuroware/dashd:$(VERSION) &&\
	docker push neuroware/dashd

.PHONY: login
login:
	docker login
