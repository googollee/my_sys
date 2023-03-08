base-compose:
	echo -n "Input password: "
	read -s PW; PW=$$PW gomplate --experimental -f base-compose.yaml.tmpl > base-compose.yaml

.SILENT: base-compose
