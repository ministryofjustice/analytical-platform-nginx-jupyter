export REGISTRY:=593291632749.dkr.ecr.eu-west-1.amazonaws.com
export NETWORK?=default
export REPOSITORY:=nginx-proxy-jupyter
export VERSION?=0.0.1
export IMAGE_TAG?=UNSET
export PROXY_PORT?=8001
export USERNAME?=test-user
export REDIRECT_DOMAIN?=127-0-0-1.nip.io:8001
export DOCKER_BUILDKIT=1

clean: 
	docker-compose down --volumes --remove-orphans

pull:
	docker-compose pull

push:
	docker push ${REGISTRY}/${REPOSITORY}:${IMAGE_TAG}

build:
		(docker rmi ${REGISTRY}/${REPOSITORY}:${IMAGE_TAG} || true) && docker build --network=${NETWORK} -t ${REGISTRY}/${REPOSITORY}:${IMAGE_TAG} nginx-proxy

up:
	docker-compose up -d jupyter-lab nginx-proxy

logs:
	docker-compose logs -f nginx-proxy

integration:
	./tests/check_is_redirecting.sh

test: build up integration clean
