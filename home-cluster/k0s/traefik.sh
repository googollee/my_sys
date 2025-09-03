helm template --namespace=infra-traefik traefik traefik/traefik-crds > traefik-crds.yaml
helm template --debug --namespace=infra-traefik --values=traefik.values.yaml traefik traefik/traefik > traefik.yaml
