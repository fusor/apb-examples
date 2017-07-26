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
	${MAKE} -C ../hello-world-apb TARGET=${TARGET}
	${MAKE} openshift-test -C ../hello-world-apb TARGET=${TARGET}
	${MAKE} -C ../jenkins-apb TARGET=${TARGET}
	${MAKE} openshift-test -C ../jenkins-apb TARGET=${TARGET}

clean:
	rm -f build