package main_test

import (
	"testing"

	"k8s.io/kubernetes/test/e2e/framework"

	_ "k8s.io/kubernetes/test/e2e/network"
	"k8s.io/kubernetes/test/e2e"
)

func init() {
	framework.ViperizeFlags()
}

func TestE2E(t *testing.T) {
	e2e.RunE2ETests(t)
}
