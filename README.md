# I Containerized the k8s e2e's.

[![Docker Pulls](https://img.shields.io/docker/pulls/ozdanborne/k8s-e2e.svg)](https://hub.docker.com/r/ozdanborne/k8s-e2e/)


#### How to run the k8s-e2e's before I containerized them:

Step 1: **Build Kubernetes**.

Step 2: Run the Kubernetes End-to-End Tests.

#### How to run the k8s-e2e's now that I containerized them:

Step 1: Run the Kubernetes End-to-End Tests.

Step 2: Congratulate yourself on not even having to build Kubernetes first.

### You too can run the k8s-e2e's on your cluster without having to build Kubernetes first.

#### Run using Docker

To run the e2e's using Docker, volume mount in a populated kubeconfig:

```
docker run -v ~/.kube/config:/root/kubeconfig ozdanborne/k8s-e2e
```

If your apiserver is running at `localhost:8080` with no auth, you can
rely on [the default kubeconfig already at `/root/kubeconfig`](https://github.com/ozdanborne/k8s-e2e-containerized/blob/run-as-plain-container/kubeconfig).

```
docker run --net=host ozdanborne/k8s-e2e
```

#### Run using Kubernetes

You can also run the e2e's as a Kubernetes pod by overriding the default
command with one which leaves out `-kubeconfig`. When omitted, the e2e's will
rely on the `KUBERNETES_SERVICE_HOST` and `KUBERNETES_SERVICE_PORT` which
are set for every pod:

```
kubectl run e2e --image=ozdanborne/k8s-e2e --restart=Never --attach -- ./e2e.test --ginkgo.focus="(Networking).*(\[Conformance\])|\[Feature:NetworkPolicy\]"
```

### Test Results XML

XML test results will be output to `/result` in the container. Volume mount this
directory onto the host to view results once the container has finished.

## Future Work

**Pass Target Apiserver as Param**

It'd be useful to accept an apiserver address as a param at runtime.
Unfortunately, I couldn't get `e2e.test` to use the `-host` passed to it.
