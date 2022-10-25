.PHONY: all update-crds update-slis

all: update-crds update-slis

update-crds:
	kustomize build \
		github.com/tsuru/nginx-operator//config/crd/?ref=main > ./charts/nginx-operator/crds/crds.yaml

	kustomize build \
		github.com/tsuru/rpaas-operator//config/crd/?ref=main > ./charts/rpaas-operator/crds/crds.yaml

	kustomize build \
		github.com/tsuru/acl-operator//config/crd/?ref=main > ./charts/acl-operator/crds/crds.yaml

update-slis:
	go get github.com/globocom/slo-generator
	slo-generator -slo.path slis/tsuru-rpaas.yaml -rule.output charts/tsuru-monitoring/files/rules/tsuru-rpaas-slis.yaml
	slo-generator -slo.path slis/tsuru-rpaas.yaml -rule.output charts/tsuru-prometheus-pool/files/rules/tsuru-rpaas-slis.yaml
