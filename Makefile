# https://kubernetes.io/docs/admin/node-conformance/
# https://github.com/kubernetes/kubernetes/blob/master/test/e2e_node/conformance/build/Dockerfile
all: build

build: bin/e2e.test
	docker build -t djosborne/k8s-e2e .

bin/e2e.test:
	mkdir -p bin
	cp $(GOPATH)/src/k8s.io/kubernetes/_output/dockerized/bin/linux/amd64/e2e.test ./bin/

