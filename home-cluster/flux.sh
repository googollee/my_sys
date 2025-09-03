# export GITHUB_TOKEN=<gh-token>

flux bootstrap github \
  --token-auth \
  --owner=googollee \
  --repository=my_sys \
  --branch=main \
  --path=home-cluster/flux \
  --personal
