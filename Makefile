SHELL := /bin/bash
.PHONY: all update-crds update-slis

all: update-crds update-slis

update-crds:
	@for chart in nginx-operator rpaas-operator acl-operator ; \
		 do \
		   kustomize build github.com/tsuru/$${chart}//config/crd/?ref=main > ./charts/$${chart}/crds/crds.yaml ;\
		   crd=$$(<./charts/$${chart}/crds/crds.yaml) ;\
		   echo "{{- if .Values.installCRDs }}" > ./charts/$${chart}/templates/crds.yaml ;\
		   echo "$$crd" >> ./charts/$${chart}/templates/crds.yaml ;\
		   echo "{{- end }}" >> ./charts/$${chart}/templates/crds.yaml; \
		 done

update-slis:
	go install github.com/globocom/slo-generator@master
	slo-generator -slo.path slis/tsuru-rpaas.yaml -rule.output charts/tsuru-monitoring/files/rules/tsuru-rpaas-slis.yaml
	slo-generator -slo.path slis/nginx-ingress.yaml -rule.output charts/tsuru-monitoring/files/rules/nginx-ingress.yaml
	slo-generator -slo.path slis/tsuru-rpaas.yaml -rule.output charts/tsuru-prometheus-pool/files/rules/tsuru-rpaas-slis.yaml

	slo-generator -disable.ticket -slo.path slis/tsuru-rpaas.yaml -rule.output charts/tsuru-monitoring/files/rules/tsuru-rpaas-slis-light.yaml
	slo-generator -disable.ticket -slo.path slis/nginx-ingress.yaml -rule.output charts/tsuru-monitoring/files/rules/nginx-ingress-slis-light.yaml
	slo-generator -disable.ticket -slo.path slis/tsuru-rpaas.yaml -rule.output charts/tsuru-prometheus-pool/files/rules/tsuru-rpaas-slis-light.yaml