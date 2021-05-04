.PHONY: update-crds clean-tmp-dirs update-crds

update-crds: clean-tmp-dirs
	git clone --depth 1 https://github.com/tsuru/nginx-operator.git ./nginx-operator
	kustomize build ./config/nginx-operator > charts/nginx-operator/templates/crds.yaml
	rm -rf ./nginx-operator

clean-tmp-dirs:
	rm -rf ./nginx-operator

update-slis:
	go get github.com/globocom/slo-generator
	slo-generator -slo.path charts/tsuru-monitoring/slis/tsuru-rpaas.yaml -rule.output charts/tsuru-monitoring/files/rules/tsuru-rpaas-slis.yaml