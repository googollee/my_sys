base-compose: output
	read -p "Input password: " -s PW; \
	PW=$$PW gomplate --experimental -f base-compose.yaml.tmpl > output/base-compose.yaml; \
	PW=$$PW gomplate --experimental -f erx.config.tmpl > output/erx.config; \
	echo \\ndone

output:
	mkdir output

.SILENT: base-compose
