FROM golang
ADD ./bin/e2e.test .
ENTRYPOINT ./e2e.test --ginkgo.focus="\[Feature:NetworkPolicy\]"
