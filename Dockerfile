# Use: docker run -v ~/.kube/config:/root/kubeconfig djosborne/k8s-e2e
# Override $FOCUS at runtime to select different tests
# Inspiration: https://github.com/kubernetes/kubernetes/blob/master/test/e2e_node/conformance/build/Dockerfile
FROM golang
LABEL maintainer "dan@projectcalico.org"
VOLUME /report
ENV FOCUS="(Networking).*(\[Conformance\])|\[Feature:NetworkPolicy\]"
ADD kubeconfig /root/kubeconfig
ADD ./bin/e2e.test .
CMD ./e2e.test -kubeconfig=/root/kubeconfig --ginkgo.focus="$FOCUS" -report-dir=/report

