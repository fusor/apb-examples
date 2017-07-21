CONTEXT = ansibleplaybookbundle
VERSION = v0.1
IMAGE_NAME = jenkins-apb
TARGET = centos7
REGISTRY = docker-registry.default.svc.cluster.local
OC_USER = developer
OC_PASS = developer
APB_APP = jenkins

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
	docker login -u ${OC_USER} -p ${OC_PASS} ${REGISTRY}:5000
	docker tag ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION} ${REGISTRY}:5000/${PROJ_RANDOM}/${IMAGE_NAME}
	docker push ${REGISTRY}:5000/${PROJ_RANDOM}/${IMAGE_NAME}
	oc create sa apb
	oc adm policy add-role-to-user admin -z apb
	oc run ${IMAGE_NAME} --image=${REGISTRY}:5000/${PROJ_RANDOM}/${IMAGE_NAME} --restart=Never --attach=true --overrides='{"apiVersion":"v1","spec":{"serviceAccountName":"apb"}}' -- provision -e namespace=${PROJ_RANDOM}
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
