IMAGE_NAME=ghcr.io/staillanibm/msr-observability
TAG=latest
DOCKER_ROOT_URL=http://localhost:15555
DOCKER_ADMIN_PASSWORD=Manage123
KUBE_ROOT_URL=https://observability.sttlab.local
KUBE_ADMIN_PASSWORD=Manage12345

docker-build:
	docker build -t $(IMAGE_NAME):$(TAG) --platform=linux/amd64 --build-arg WPM_TOKEN=${WPM_TOKEN} --build-arg GIT_TOKEN=${GIT_TOKEN} .

docker-login-whi:
	@echo ${WHI_CR_PASSWORD} | docker login ${WHI_CR_SERVER} -u ${WHI_CR_USERNAME} --password-stdin

docker-login-gh:
	@echo ${GH_CR_PASSWORD} | docker login ${GH_CR_SERVER} -u ${GH_CR_USERNAME} --password-stdin

docker-login-cp:
	@echo ${IBM_CR_PASSWORD} | docker login cp.icr.io -u cp --password-stdin	

docker-push:
	docker push $(IMAGE_NAME):$(TAG)

docker-run:
	cd resources/compose && ./up.sh

docker-stop:
	cd resources/compose && ./down.sh

docker-logs:
	docker logs msr-sandbox

docker-logs-f:
	docker logs -f msr-sandbox

kube-test-hello:
	ROOT_URL=${KUBE_ROOT_URL} USER=Administrator PASSWORD=${KUBE_ADMIN_PASSWORD} ./resources/scripts/run-hello.sh 1 make

kube-test-mem:
	ROOT_URL=${KUBE_ROOT_URL} USER=Administrator PASSWORD=${KUBE_ADMIN_PASSWORD} ./resources/scripts/run-memory.sh 1

kube-restart:
	kubectl rollout restart deployment stt-contact-management -n integration

kube-get-pods:
	kubectl get pods -l app=stt-contact-management -n integration

kube-logs-f:
	kubectl logs -l app=stt-contact-management -n integration --all-containers=true -f --prefix



