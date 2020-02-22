Jellyfin
========

A Helm chart for deploying the [Jellyfin](https://jellyfin.org) media system on Kubernetes.

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

## Chart Values

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
| persistence.cache.enabled | bool | `false` | Enables persistence for the cache directory |
| persistence.cache.existingClaim | string | `nil` |  Set to use an existing PVC instead of creating a new one. |
| persistence.cache.size | string | `"8Gi"` | ize/capacity of the PVC |
| persistence.cache.storageClass | string | `default` | (Optional) StorageClass to use for the PVC |
| persistence.config.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.config.annotations | object | `{}` | (Optional) annotations to add to the PVC |
| persistence.config.enabled | bool | `false` | Enables persistence for the config directory |
| persistence.config.existingClaim | string | `nil` | Set to use an existing PVC instead of creating a new one. |
| persistence.config.size | string | `"8Gi"` | size/capacity of the PVC |
| persistence.config.storageClass | string | `default` | (Optional) StorageClass to use for the PVC |
| persistence.media.nfs.path | string | `nil` | Path of NFS Share to mount for Media |
| persistence.media.nfs.server | string | `nil` | Host or IP address of the NFS Share to mount for Media |
| persistence.media.pvc.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.media.pvc.annotations | object | `{}` | (Optional) annotations to add to the PVC |
| persistence.media.pvc.enabled | bool | `false` | Enables persistence of for the media directory |
| persistence.media.pvc.existingClaim | string | `nil` | Set to use an existing PVC instead of creating a new one. |
| persistence.media.pvc.size | string | `"8Gi"` | size/capacity of the PVC |
| persistence.media.storageClass | string | `default` | (Optional) StorageClass to use for the PVC |
| podSecurityContext | object | `{}` | Set Pod security contexts |
| resources | object | `{}` | Set resource limits/requests for the Pod(s) |
| securityContext | object | `{}` | Set Security Context |
| service.port | int | `80` | Port the Service should communicate on |
| service.type | string | `"ClusterIP"` | Type of Service to use |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | Node toleration configuration |
