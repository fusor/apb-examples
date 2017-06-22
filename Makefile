DIRS = \
apb-base \
hello-world-apb

# Allow user to pass in OS build options
ifeq ($(TARGET),rhel7)
	DFILE := Dockerfile.${TARGET}
else
	TARGET := centos7
	DFILE := Dockerfile
endif

all: build
build: 
	@for d in ${DIRS}; do ${MAKE} -C $$d TARGET=${TARGET}; done

lint:
	@for d in ${DIRS}; do ${MAKE} lint -C $$d; done

clean:
	@for d in ${DIRS}; do ${MAKE} clean -C $$d; done