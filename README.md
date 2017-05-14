# I Containerized the k8s e2e's.

[![Docker Pulls](https://img.shields.io/docker/pulls/ozdanborne/k8s-e2e.svg)](https://hub.docker.com/r/ozdanborne/k8s-e2e/)


#### How to run the k8s-e2e's before I containerized them:

Step 1: **Build Kubernetes**.

Step 2: Run the Kubernetes End-to-End Tests.

#### How to run the k8s-e2e's now that I containerized them:

Step 1: Run the Kubernetes End-to-End Tests.

Step 2: Congratulate yourself on not even having to build Kubernetes first.

### You too can run the k8s-e2e's on your cluster __without having to build Kubernetes first__.

With:

```
docker run --net=host ozdanborne/k8s-e2e
```

#### Why `--net=host`?`

Seems that `e2e.test` doesn't just accept the address of your cluster as an argument.
You either have to:

1. Run it as a Pod, in your cluster. Or,

2. Run as a regular ole' container **with a populated kubeconfig**.

I took the liberty of building
[a static kubeconfig that connects to a cluster at localhost:8080](https://github.com/ozdanborne/k8s-e2e-containerized/blob/run-as-plain-container/kubeconfig), 
just for you. 

If you need to connect it to a different cluster, just volume mount your own
kubeconfig in:

```
docker run -v ~/.kube/config:/root/kubeconfig ozdanborne/k8s-e2e
```

## Future Work

I either need to figure out how to get e2e.test to use the
damn `-host` I'm passing it. Or add some environment variable templating so that
you can inject the apiserver address into the kubeconfig file at runtime.

