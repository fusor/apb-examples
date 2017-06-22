CONTEXT = ansibleplaybookbundle
VERSION = v2.3
IMAGE_NAME = apb-base
TARGET = centos7
REGISTRY = docker-registry.default.svc.cluster.local
OC_USER = developer
OC_PASS = developer

# Allow user to pass in OS build options
ifeq ($(TARGET),rhel7)
	DFILE := Dockerfile.${TARGET}
else
	DFILE := Dockerfile
endif

all: build
build:
	docker build --pull -t ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION} -t ${CONTEXT}/${IMAGE_NAME} -f ${DFILE} .
	@if docker images ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION}; then touch build; fi

lint:
	dockerfile_lint -f Dockerfile
#	dockerfile_lint -f Dockerfile.rhel7

openshift-test:
	$(eval PROJ_RANDOM=test-$(shell shuf -i 100000-999999 -n 1))
	oc login -u ${OC_USER} -p ${OC_PASS}
	oc new-project ${PROJ_RANDOM}
	oc adm policy add-role-to-user admin system:serviceaccount:${PROJ_RANDOM}:default
	docker login -u ${OC_USER} -p ${OC_PASS} ${REGISTRY}:5000
	docker tag ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION} ${REGISTRY}:5000/${PROJ_RANDOM}/${IMAGE_NAME}
	docker push ${REGISTRY}:5000/${PROJ_RANDOM}/${IMAGE_NAME}
	oc project ${PROJ_RANDOM}
	oc run ${IMAGE_NAME} --image=${REGISTRY}:5000/${PROJ_RANDOM}/${IMAGE_NAME}
	oc rollout status -w dc/${IMAGE_NAME}
	oc describe dc/${IMAGE_NAME}
	oc logs -f dc/${IMAGE_NAME}

clean:
	rm -f build