CONTEXT = ansibleplaybookbundle
VERSION = v0.1
IMAGE_NAME = mongodb-apb
DISTRO = centos7
REGISTRY = 172.30.1.1:5000
OC_USER = developer
OC_PASS = developer
APB_APP = mongodb
APB_SPEC = `base64 --wrap=0 apb.yml`
IMAGE = ${CONTEXT}/${IMAGE_NAME}:${DISTRO}-${VERSION}

ifneq ($(shell oc whoami . 2> /dev/null; echo $$?), 0)
	loggedin = $(shell oc login -u ${OC_USER} -p ${OC_PASS})
endif
ifndef project
	export project = $(shell oc project -q)
endif

all: localtest localteardown build push

.PHONY: localbuild
localbuild:
	docker build --no-cache \
		--label "com.redhat.apb.version=${VERSION}" \
		--label "com.redhat.apb.spec=${APB_SPEC}" \
		-t ${CONTEXT}/${IMAGE_NAME}:${DISTRO}-${VERSION} \
		-t ${CONTEXT}/${IMAGE_NAME} .

.PHONY: build
build:
	apb build --tag ${CONTEXT}/${IMAGE_NAME}:${DISTRO}-${VERSION}

.PHONY: push
push:
	docker login -u ${OC_USER} -p `oc whoami -t` ${REGISTRY}
	docker tag ${CONTEXT}/${IMAGE_NAME}:${DISTRO}-${VERSION} \
		${REGISTRY}/${project}/${IMAGE_NAME}
	docker push ${REGISTRY}/${project}/${IMAGE_NAME}
	apb push

.PHONY: buildopenshift
buildopenshift:
	oc patch bc/${APB_APP} --patch="{\"spec\": {\"output\": {\"imageLabels\":[{\"name\":\"com.redhat.apb.spec\", \"value\": \"${APB_SPEC}\"}]}}}" ${project}
	oc start-build ${APB_APP} -n ${project}

test: localtest localteardown

.PHONY: localtest
localtest:
	ANSIBLE_STRATEGY=debug
	ansible-playbook playbooks/provision.yml --extra-vars namespace=${project} --extra-vars _apb_plan_id=prod

.PHONY: localteardown
localteardown:
	ANSIBLE_STRATEGY=debug
	ansible-playbook playbooks/deprovision.yml --extra-vars namespace=${project} --extra-vars _apb_plan_id=prod
