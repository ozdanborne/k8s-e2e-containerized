# Containerized k8s e2e's.

Container distributor for the build artifact `e2e.test` of Kubernetes.

To use, run as a pod:

```
kubectl run e2e --image=djosborne/k8s-e2e
```

- Currently filters down to just network policy tests.
- Currently only works when run as a pod (help wanted)
- Currently fails all tests (lol)

