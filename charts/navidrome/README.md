# navidrome

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.46.0](https://img.shields.io/badge/AppVersion-0.46.0-informational?style=flat-square)

A Helm chart to deploy Navidrome

Refer to [Navidrome](https://www.navidrome.org/) for more info.

**Homepage:** <https://github.com/maxirus/helm-charts/tree/master/charts/navidrome>

## Install

Using [Helm](https://helm.sh), you can easily install and test Navidrome in a
Kubernetes cluster by running the following:

```bash
helm upgrade --install \
  my-release
  maxirus/navidrome
```

## Source Code

* <https://github.com/maxirus/helm-charts/tree/master/charts/navidrome>
* <https://github.com/navidrome/navidrome/>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Set Pod affinity rules |
| config | object | `{"DataFolder":"/data","LastFM":{"Enabled":true},"LogLevel":"DEBUG","MusicFolder":"/music","Port":4533,"ScanSchedule":"@every 1h","TranscodingCacheSize":"150MiB"}` | Navidrome Configuration settings. See [docs](https://www.navidrome.org/docs/usage/configuration-options/) for details. |
| fullnameOverride | string | `""` | Overrides the Full Name of resources |
| image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| image.pullSecrets | list | `[]` | Secrets to use when pulling Docker images |
| image.repository | string | `"deluan/navidrome"` | Docker registry/repository to pull the image from |
| image.tag | string | `""` | Overrides the default tag used |
| ingress.annotations | object | `{}` | annotations to configure your Ingress. See your Ingress Controller's Docs for more info. |
| ingress.enabled | bool | `false` | Enables the use of an Ingress Controller to front the Service and provide HTTPS |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":[]}]` | list of hosts and their paths that ingress controller should repsond to. |
| ingress.tls | list | `[]` | list of TLS configurations |
| nameOverride | string | `""` | Overrides the name of resources |
| nodeSelector | object | `{}` | Node Selector configuration |
| persistence.data.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.data.annotations | object | `{}` | (Optional) annotations to add to the PVC |
| persistence.data.enabled | bool | `false` | Enables persistence for the config directory |
| persistence.data.existingClaim | string | `nil` | Set to use an existing PVC instead of creating a new one. |
| persistence.data.size | string | `"8Gi"` | size/capacity of the PVC |
| persistence.music.nfs.path | string | `nil` | Path of NFS Share to mount for music |
| persistence.music.nfs.server | string | `nil` | Host or IP address of the NFS Share to mount for music |
| persistence.music.pvc.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.music.pvc.annotations | object | `{}` | (Optional) annotations to add to the PVC |
| persistence.music.pvc.enabled | bool | `false` | Enables persistence of for the music directory |
| persistence.music.pvc.existingClaim | string | `nil` | Set to use an existing PVC instead of creating a new one. |
| persistence.music.pvc.size | string | `"8Gi"` | size/capacity of the PVC |
| podAnnotations | object | `{}` | Pod annotations to add |
| podSecurityContext | object | `{}` | Set Pod security contexts |
| replicaCount | int | `1` |  |
| resources | object | `{}` | Set resource limits/requests for the Pod(s) |
| securityContext | object | `{}` | Set Security Context |
| service.port | int | `80` | Port the Service should communicate on |
| service.type | string | `"ClusterIP"` | Type of Service to use |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | (string) name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | Node toleration configuration |