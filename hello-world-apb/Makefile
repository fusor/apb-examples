CONTEXT = ansibleplaybookbundle
VERSION = v0.1
IMAGE_NAME = hello-world-apb
TARGET = centos7
REGISTRY = docker-registry.default.svc.cluster.local
OC_USER = developer
OC_PASS = developer
APB_APP = hello-world

# Allow user to pass in OS build options
ifeq ($(TARGET),rhel7)
	DFILE := Dockerfile.${TARGET}
else
	DFILE := Dockerfile
endif

all: build
build:
	docker build -t ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION} -t ${CONTEXT}/${IMAGE_NAME} -f ${DFILE} .
	@if docker images ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION}; then touch build; fi

lint:
	dockerfile_lint -f Dockerfile
#	dockerfile_lint -f Dockerfile.rhel7

openshift-test:
	$(eval PROJ_RANDOM=test-$(shell shuf -i 100000-999999 -n 1))
	oc login -u ${OC_USER} -p ${OC_PASS}
	oc new-project ${PROJ_RANDOM}
	oc new-project ${APB_APP}
	oc adm policy add-role-to-user admin system:serviceaccount:${PROJ_RANDOM}:default
	docker login -u ${OC_USER} -p ${OC_PASS} ${REGISTRY}:5000
	docker tag ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION} ${REGISTRY}:5000/${PROJ_RANDOM}/${IMAGE_NAME}
	docker push ${REGISTRY}:5000/${PROJ_RANDOM}/${IMAGE_NAME}
	oc project ${PROJ_RANDOM}
	oc run ${IMAGE_NAME} --image=${REGISTRY}:5000/${PROJ_RANDOM}/${IMAGE_NAME} -- provision --extra-vars 'namespace=${APB_APP}'
	oc rollout status -w dc/${IMAGE_NAME}
	oc describe dc/${IMAGE_NAME}
	oc logs -f dc/${IMAGE_NAME}
	oc project ${APB_APP}
	oc rollout status -w dc/${APB_APP}
	oc status
	sleep 5
	oc describe pod `oc get pod --template '{{(index .items 0).metadata.name }}'`
	curl `oc get svc/${APB_APP} --template '{{.spec.clusterIP}}:{{index .spec.ports 0 "port"}}'`
	oc exec `oc get pod --template '{{(index .items 0).metadata.name }}'` ps aux

#run:
#	docker run -tdi -u $(shell shuf -i 1000010000-1000020000 -n 1) ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION}

clean:
	rm -f build