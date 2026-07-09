.PHONY: test deps lint run docker_build docker_run docker_push

deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

test:
	PYTHONPATH=. py.test

run:
	PYTHONPATH=. FLASK_APP=hello_world flask run

docker_build:
	docker build -t hello-world-printer .

docker_push: docker_build
	@echo "$(DOCKER_PASSWORD)" | docker login -u "$(DOCKER_USER)" --password-stdin
	docker tag hello-world-printer $(DOCKER_USER)/hello-world-printer:latest
	docker push $(DOCKER_USER)/hello-world-printer:latest
	docker logout