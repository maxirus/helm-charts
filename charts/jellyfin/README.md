# jellyfin

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 10.7.7](https://img.shields.io/badge/AppVersion-10.7.7-informational?style=flat-square)

A Helm chart for deploying Jellyfin on Kubernetes

Refer to [Jellyfin](https://jellyfin.org) for more info.

**Homepage:** <https://github.com/maxirus/helm-charts/tree/master/charts/jellyfin>

## Install

Using [Helm](https://helm.sh), you can easily install and test Jellyfin in a
Kubernetes cluster by running the following:

```bash
helm upgrade --install \
  my-release
  maxirus/jellyfin
```

#### Knonw Limitations
- There is currently a [Bug](https://github.com/jellyfin/jellyfin/issues/2126) in the Official Jellyfin Docker image for ARM (RPi). Use the [linuxserver/jellyfin](https://hub.docker.com/r/linuxserver/jellyfin) image instead.
- This chart currently does not support GPU resources
- Liveness probe not yet implemented

## Source Code

* <https://github.com/maxirus/helm-charts/tree/master/charts/jellyfin>
* <https://github.com/jellyfin/jellyfin>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Set Pod affinity rules |
| fullnameOverride | string | `""` | Overrides the Full Name of resources |
| image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| image.pullSecrets | list | `[]` | Secrets to use when pulling Docker images |
| image.repository | string | `"jellyfin/jellyfin"` | Docker registry/repository to pull the image from |
| image.tag | string | `nil` | Overrides the default tag used |
| ingress.annotations | object | `{}` | annotations to configure your Ingress. See your Ingress Controller's Docs for more info. |
| ingress.enabled | bool | `false` | Enables the use of an Ingress Controller to front the Service and provide HTTPS |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":[]}]` | list of hosts and their paths that ingress controller should repsond to. |
| ingress.tls | list | `[]` | list of TLS configurations |
| nameOverride | string | `""` | Overrides the name of resources |
| nodeSelector | object | `{}` | Node Selector configuration |
| persistence.cache.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.cache.annotations | object | `{}` | (Optional) annotations to add to the PVC |
| persistence.cache.enabled | bool | `false` | Enables persistence for the config directory |
| persistence.cache.existingClaim | string | `nil` | Set to use an existing PVC instead of creating a new one. |
| persistence.cache.size | string | `"8Gi"` | size/capacity of the PVC |
| persistence.config.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.config.annotations | object | `{}` | (Optional) annotations to add to the PVC |
| persistence.config.enabled | bool | `false` | Enables persistence for the config directory |
| persistence.config.existingClaim | string | `nil` | Set to use an existing PVC instead of creating a new one. |
| persistence.config.size | string | `"8Gi"` | size/capacity of the PVC |
| persistence.media.nfs.path | string | `nil` | Path of NFS Share to mount for Media |
| persistence.media.nfs.server | string | `nil` | Host or IP address of the NFS Share to mount for Media |
| persistence.media.pvc.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.media.pvc.annotations | object | `{}` | (Optional) annotations to add to the PVC |
| persistence.media.pvc.enabled | bool | `false` | Enables persistence of for the media directory |
| persistence.media.pvc.existingClaim | string | `nil` | Set to use an existing PVC instead of creating a new one. |
| persistence.media.pvc.size | string | `"8Gi"` | size/capacity of the PVC |
| podSecurityContext | object | `{}` | Set Pod security contexts |
| replicaCount | int | `1` |  |
| resources | object | `{}` | Set resource limits/requests for the Pod(s) |
| securityContext | object | `{}` | Set Security Context |
| service.loadBalancerIP | string | `nil` | Set specific IP address for LoadBalancer. `service.type` must be set to `LoadBalancer` |
| service.port | int | `80` | Port the Service should communicate on |
| service.type | string | `"ClusterIP"` | Type of Service to use |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| tolerations | list | `[]` | Node toleration configuration |