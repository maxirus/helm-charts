# motioneye

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.42.1](https://img.shields.io/badge/AppVersion-0.42.1-informational?style=flat-square)

A Helm chart to deploy motionEye in Kubernetes

**Homepage:** <https://github.com/maxirus/helm-charts/tree/master/charts/motioneye>

## Install

Using [Helm](https://helm.sh), you can easily install and test motionEye in a
Kubernetes cluster by running the following:

#### amd64
```bash
helm upgrade --install \
  my-release
  maxirus/motioneye
```

#### armhf (RaspberryPi)
```bash
helm upgrade --install \
  my-release
  maxirus/motioneye \
  --set image.tag=0.42-armhf
```

#### Knonw Limitations
- This chart currently does not support GPU resources

## Source Code

* <https://github.com/maxirus/helm-charts/tree/master/charts/motioneye>
* <https://github.com/jellyfin/jellyfin>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Set Pod affinity rules |
| fullnameOverride | string | `""` | Set to override the Full Name of resources |
| image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| image.repository | string | `"ccrisan/motioneye"` | Docker registry/repository to pull the image from |
| image.tag | string | `"0.42-amd64"` | Version/Arch of Docker image to use. Change to `0.42-armhf` for RaspberyPi. |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` | annotations to configure your Ingress. See your Ingress Controller's Docs for more info. |
| ingress.enabled | bool | `false` | Enables the use of an Ingress Controller to front the Service and provide HTTPS |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":[]}]` | list of hosts and their paths that ingress controller should repsond to. |
| ingress.tls | list | `[]` | list of TLS configurations |
| nameOverride | string | `""` | Set to overrides the name of resources |
| nodeSelector | object | `{}` | Node Selector configuration |
| persistence.config.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.config.annotations | object | `{}` | (Optional) annotations to add to the PVC |
| persistence.config.enabled | bool | `false` | Enables persistence for the config directory |
| persistence.config.existingClaim | string | `nil` | Set to use an existing PVC instead of creating a new one. |
| persistence.config.size | string | `"8Gi"` | size/capacity of the PVC |
| persistence.data.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.data.annotations | object | `{}` | (Optional) annotations to add to the PVC |
| persistence.data.enabled | bool | `false` | Enables persistence for the data directory |
| persistence.data.existingClaim | string | `nil` | Set to use an existing PVC instead of creating a new one. |
| persistence.data.size | string | `"24Gi"` | size/capacity of the PVC |
| podSecurityContext | object | `{}` | Set Pod security contexts |
| resources | object | `{}` | Set resource limits/requests for the Pod(s) |
| securityContext | object | `{}` | Set Security Context |
| service.port | int | `80` | Port the Service should communicate on |
| service.type | string | `"ClusterIP"` | Type of Service to use |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| tolerations | list | `[]` | Node toleration configuration |