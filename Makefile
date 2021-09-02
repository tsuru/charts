.PHONY: update-crds clean-tmp-dirs update-crds

update-crds: clean-tmp-dirs
	git clone --depth 1 https://github.com/tsuru/nginx-operator.git ./nginx-operator
	git clone --depth 1 https://github.com/tsuru/rpaas-operator.git ./rpaas-operator

	kustomize build ./config/nginx-operator > charts/nginx-operator/templates/crds.yaml
	kustomize build ./config/rpaas-operator > charts/rpaas-operator/templates/crds.yaml

	rm -rf ./nginx-operator
	rm -rf ./rpaas-operator

clean-tmp-dirs:
	rm -rf ./nginx-operator
	rm -rf ./rpaas-operator

update-slis:
	go get github.com/globocom/slo-generator
	slo-generator -slo.path slis/tsuru-rpaas.yaml -rule.output charts/tsuru-monitoring/files/rules/tsuru-rpaas-slis.yaml
	slo-generator -slo.path slis/tsuru-rpaas.yaml -rule.output charts/tsuru-prometheus-pool/files/rules/tsuru-rpaas-slis.yaml
