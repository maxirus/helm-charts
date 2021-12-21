# intel-gpu

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.22.0](https://img.shields.io/badge/AppVersion-0.22.0-informational?style=flat-square)

A Helm chart to deploy the Intel GPU Device plugin on Kubernetes

Deploys the [Intel GPU Device Plugin](https://github.com/intel/intel-device-plugins-for-kubernetes#gpu-device-plugin) into a Kubernetes cluster, using Helm. See their official docs [here](https://github.com/intel/intel-device-plugins-for-kubernetes/blob/main/cmd/gpu_plugin/README.md).

**Homepage:** <https://github.com/maxirus/helm-charts/tree/master/charts/intel-gpu>

## Install

Using [Helm](https://helm.sh), you can easily install the Intel GPU Device Plugin in a
Kubernetes cluster by running the following:

```bash
helm upgrade --install \
  my-release maxirus/intel-gpu
```

If you're running [Node Feature Discovery](https://kubernetes-sigs.github.io/node-feature-discovery/stable/get-started/index.html) within your cluster, you can limit the DaemonSet to compatible nodes using the proper `nodeSelector`:
If your device shows as a *Display Controller*, use `feature.node.kubernetes.io/pci-0380_8086.present: "true"`. If your device shows as a *VGA Controller*, use `feature.node.kubernetes.io/pci-0300_8086.present: "true"`. See below for more info.

```yaml
# my-values.yaml
nodeSelector:
  # feature.node.kubernetes.io/pci-0380_8086.present: "true" # Display controller
  feature.node.kubernetes.io/pci-0300_8086.present: "true" # VGA COntroller
```

```bash
helm upgrade --install \
  my-release maxirus/intel-gpu \
  -f my-values.yaml
```

## Display/VGA Controller

I'm not exactly sure what constitutes a *Display Controller* vs. a *VGA Controller* but I suspect it has to do with having multiple GPUs and one being primary/active. In order to determine which one you have, run the following on your node:
```bash
lspci -nn | grep -E '(0380|0300).*8086'
```

Example:
```bash
# lspci -nn | grep -E '(0380|0300).*8086'
00:02.0 Display controller [0380]: Intel Corporation CometLake-S GT2 [UHD Graphics 630] [8086:9bc8] (rev 03)
```

You would then set you `nodeSelector` appropriately as outlined above.

> NOTE: This currently has a disadvantage of not being able to run on either type on controller as the nodeSelector is a "match all".

## Source Code

* <https://github.com/maxirus/helm-charts/tree/master/charts/intel-gpu>
* <https://github.com/intel/intel-device-plugins-for-kubernetes/blob/main/cmd/gpu_plugin/README.md>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"intel/intel-gpu-plugin"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| initContainerImage.pullPolicy | string | `"IfNotPresent"` |  |
| initContainerImage.repository | string | `"intel/intel-gpu-initcontainer"` |  |
| initContainerImage.tag | string | `""` |  |
| nameOverride | string | `""` |  |
| nodeSelector."kubernetes.io/arch" | string | `"amd64"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| resources | object | `{}` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
