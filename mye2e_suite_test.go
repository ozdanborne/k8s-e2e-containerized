package main_test

import (
	"testing"

  "k8s.io/kubernetes/test/e2e/framework"

  "k8s.io/kubernetes/test/e2e"
	_ "k8s.io/kubernetes/test/e2e/apimachinery"
	_ "k8s.io/kubernetes/test/e2e/apps"
	_ "k8s.io/kubernetes/test/e2e/auth"
	_ "k8s.io/kubernetes/test/e2e/autoscaling"
	_ "k8s.io/kubernetes/test/e2e/common"
	_ "k8s.io/kubernetes/test/e2e/instrumentation"
	_ "k8s.io/kubernetes/test/e2e/kubectl"
	_ "k8s.io/kubernetes/test/e2e/lifecycle"
	_ "k8s.io/kubernetes/test/e2e/lifecycle/bootstrap"
	_ "k8s.io/kubernetes/test/e2e/network"
	_ "k8s.io/kubernetes/test/e2e/node"
	_ "k8s.io/kubernetes/test/e2e/scalability"
	_ "k8s.io/kubernetes/test/e2e/scheduling"
	_ "k8s.io/kubernetes/test/e2e/servicecatalog"
	_ "k8s.io/kubernetes/test/e2e/storage"
)

func init() {
  framework.ViperizeFlags()
}

func TestE2E(t *testing.T) {
  e2e.RunE2ETests(t)
}
