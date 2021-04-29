
update-slis:
	go get github.com/globocom/slo-generator
	slo-generator -slo.path charts/tsuru-monitoring/slis/tsuru-rpaas.yaml -rule.output charts/tsuru-monitoring/files/rules/tsuru-rpaas-slis.yaml

