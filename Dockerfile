# Use: docker run -v ~/.kube/config:/root/kubeconfig djosborne/k8s-e2e
# Override $FOCUS at runtime to select different tests
# Inspiration: https://github.com/kubernetes/kubernetes/blob/master/test/e2e_node/conformance/build/Dockerfile
FROM golang
LABEL maintainer "dan@projectcalico.org"
RUN go get github.com/Masterminds/glide
RUN go get -u github.com/jteeuwen/go-bindata/...
WORKDIR /go/src/github.com/ozdanborne/k8s-e2e-containerized
ADD glide.yaml .
ADD glide.lock .
RUN glide install -v
# generate go-bindata. see: https://github.com/kubernetes/kubernetes/issues/24976
RUN cd vendor/k8s.io/kubernetes && \
    go-bindata \
    -pkg generated -ignore .jpg -ignore .png -ignore .md \
    ./examples/* ./docs/user-guide/* test/e2e/testing-manifests/kubectl/* test/images/* && mv bindata.go test/e2e/generated
ADD src .
RUN CGO_ENABLED=0 go test -c -o e2e.test .
FROM alpine:3.6
VOLUME /report
COPY --from=0 /go/src/github.com/ozdanborne/k8s-e2e-containerized/e2e.test /usr/local/bin/e2e.test
ADD kubeconfig /root/kubeconfig
ENV FOCUS="(Networking).*(\[Conformance\])|\[Feature:NetworkPolicy\]"
CMD e2e.test -kubeconfig=/root/kubeconfig --ginkgo.focus="$FOCUS" -report-dir=/report

