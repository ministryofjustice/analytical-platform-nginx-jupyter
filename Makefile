export REGISTRY := 593291632749.dkr.ecr.eu-west-1.amazonaws.com
export NETWORK ?= default
export CHEF_LICENSE := accept-no-persist
export REPOSITORY := nginx-jupyter
export VERSION ?= 0.0.1


export DOCKER_BUILDKIT=1

clean: down

rstudio:
	docker-compose up rstudio

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
	docker-compose run --rm inspec check tests
	docker-compose run --rm inspec exec tests

test: up integration clean
