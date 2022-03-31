export REGISTRY := 593291632749.dkr.ecr.eu-west-1.amazonaws.com
export NETWORK ?= default
export CHEF_LICENSE := accept-no-persist
export REPOSITORY := nginx-jupyter
export VERSION ?= 0.0.1
export IMAGE_TAG ?= UNSET
export PROXY_PORT ?= 8001
export USERNAME ?= test-user
export REDIRECT_DOMAIN ?= dev-127.0.0.1.nip.io
export DOCKER_BUILDKIT=1

clean: down

jupyter-lab:
	docker-compose up jupyter-lab

pull:
	docker-compose pull

push:
	docker push ${REGISTRY}/${REPOSITORY}:${IMAGE_TAG}

build:
	docker build --network=${NETWORK} -t ${REGISTRY}/${REPOSITORY}:${IMAGE_TAG} nginx-proxy

up:
	docker-compose up -d jupyter-lab nginx-proxy

logs:
	docker-compose logs -f nginx-proxy

down:
	docker-compose down --volumes --remove-orphans

enter:
	docker-compose run --entrypoint sh ${REPOSITORY}

integration:
	./tests/check_is_redirecting.sh

test: build up integration clean
