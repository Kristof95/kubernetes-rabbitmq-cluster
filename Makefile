DOCKER_TARGET_IMAGE=advinans/k8s-rabbitmq
VERSION=$(shell cat VERSION)
DOCKER_IMAGE_WITH_TAG=$(DOCKER_TARGET_IMAGE):$(VERSION)

.PHONY:
build-docker:
ifndef VERSION
$(error could not find VERSION file)
endif
	@echo "Building image $(DOCKER_IMAGE_WITH_TAG)"
	@docker build --build-arg -t $(DOCKER_IMAGE_WITH_TAG) .

.PHONY: gcloud-push
gcloud-push:
	@docker push $(DOCKER_IMAGE_WITH_TAG)
