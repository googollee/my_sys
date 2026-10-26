# k0s update channels

由 `.github/workflows/k0s-update-channel.yaml` 每天从 [k0s releases](https://github.com/k0sproject/k0s/releases) 生成，不要手改 `stable/`。

- `stable/index.yaml`：最新 stable 版本，会跨小版本。
- `stable/v1.MINOR/index.yaml`：最近 3 个小版本各自的最新补丁版本。

autopilot 使用方式：

```yaml
spec:
  updateServer: https://raw.githubusercontent.com/googollee/my_sys/main/home-cluster/k0s-update/
  channel: stable          # 或 stable/v1.36，只做补丁升级
```
