# Zigbee OTA index

由 `.github/workflows/zigbeetlc-ota-index.yaml` 每天从 [pvvx/ZigbeeTLc](https://github.com/pvvx/ZigbeeTLc) 最新的正式 Release 生成，不要手改 `zigbeetlc.json`。

- 只跟 GitHub Release（非 prerelease）。上游 beta 与正式版同版本号、同文件名，只能靠 Release 区分。
- 取该 tag 下的 `bin/index_v*.json`（纯 Zigbee 固件，不含 `bin_zb` 的 ZB 版），镜像 URL 改写为指向该 tag，保证 URL、大小、sha512 一致；生成时会下载每个镜像校验。
- 拒绝降级到更旧的 tag。

ZHA 使用方式（`/config/configuration.yaml`）：

```yaml
zha:
  zigpy_config:
    ota:
      extra_providers:
        - type: z2m
          url: https://raw.githubusercontent.com/googollee/my_sys/main/home-cluster/zigbee-ota/zigbeetlc.json
```
