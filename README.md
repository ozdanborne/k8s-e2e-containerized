# Containerized Kubernetes e2e's

[![Docker Pulls](https://img.shields.io/docker/pulls/ozdanborne/k8s-e2e.svg)](https://hub.docker.com/r/ozdanborne/k8s-e2e/)

#### Usage

If your k8s-apiserver is running at `localhost:8080` with no auth:

```
docker run --net=host ozdanborne/k8s-e2e
```

Otherwise, volume mount your own kubeconfig:

```bash
docker run --net=host -v ~/.kube/config:/root/kubeconfig ozdanborne/k8s-e2e
```

###### Configure ginkgo.focus

```
docker run --net=host -e FOCUS='Conformance' ozdanborne/k8s-e2e
```

###### XML Results

XML test results will be output to `/result` in the container. Volume mount this
directory onto the host to view results once the container has finished:

```docker run --net=host ozdanborne/k8s-e2e
docker run --net=host -v ./result:/result ozdanborne/k8s-e2e
```

####  Building

###### Docker Image

```
docker build -t ozdanborne/k8s-e2e:dev .
```

> Docker builds use multi-stage builds and do not leave a binary on the host. If you need a binary on the host, you must manually build it (see next section).

###### Binary

1. Install glide dependencies:

   ```
   glide install -v
   ```

2. Generate go-bindata for Kubernetes:

   ```
   pushd vendor/k8s.io/kubernetes
   go-bindata \
     -pkg generated -ignore .jpg -ignore .png -ignore .md \
     ./examples/* ./docs/user-guide/* test/e2e/testing-manifests/kubectl/* test/images/*
   mv bindata.go test/e2e/generated
   popd
   ```

3. Build e2e.test

   ```
   go test -o e2e.test -c .
   ```

