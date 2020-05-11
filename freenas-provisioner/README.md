# FreeNAS Provisioner

This Helm Chart deploys the [nmaupu/freenas-provisioner](https://github.com/nmaupu/freenas-provisioner) into your Kubernetes cluster. It provides a StorageClass that is backed by FreeNAS via NFS.

## Setup

Create a new Dataset in your FreeNAS pool that will be dedicated to Kubernetes PVCs.

Under Services, make sure the NFS service is running and that the *Start Automatically* box is checked. Next click on the *Configure* icon and check your settings. If `Enable NFSv4` is checked, ensure `NFSv3 ownership model for NFSv4` is also checked as this will cause issues for containers that need to chown/chmod files/directories.

For each Kubernetes node in your cluster, install the nfs client utils:

*Ubuntu/Debian:*
```sh
sudo apt-get update
sudo apt-get -y install nfs-common
```

*CentOS/RHEL*
```sh
sudo yum makecache fast
sudo yum -y install nfs-utils
```

## Install

Using [Helm](https://helm.sh), you can easily install the FreeNAS Provisioner in a 
Kubernetes cluster by running the following:

```
helm upgrade --install \
  my-release
  maxirus/freenas-provisioner \
  --set 'freenasConfig.host=<ip_or_hostname>' \
  --set 'storageClass.parameters.datasetParentName=<pool/dataset_name>' \
  --set 'freenasConfig.password=<root_password>
```

### Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Set Pod affinity rules |
| freenasConfig.allowInsecure | bool | `false` | Allow for self-signed/untrusted certs if using https |
| freenasConfig.host | string | `"localhost"` | Host at which FreeNAS can be reached at. Set to localhost for running the provisioner out of cluster directly on FreeNAS node |
| freenasConfig.port | int | `80` | Port FreeNAS is running on. Usually 80 for http and 443 for https |
| freenasConfig.protocol | string | `"http"` | Protocol to use to access the FreeNAS API. Valid values are http or https |
| freenasConfig.secretName | string | `"freenas-nfs"` | name of the secret which contains FreeNAS server connection details |
| freenasConfig.useExistingSecret | bool | `false` | Set this to true to use your own Secret, created outside of this deployment |
| freenasConfig.username | string | `"root"` | Do not change. API is only available for root currently |
| freenasConfig.password | string | `nil` | Password for root user. NEVER set this in a file. Use --set freenasConfig.password=<your_password> instead |
| fullnameOverride | string | `""` | Overrides the Full Name of resources |
| image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| image.pullSecrets | list | `[]` | Secrets to use when pulling Docker images |
| image.repository | string | `"docker.io/nmaupu/freenas-provisioner"` | Docker registry/repository to pull the image from |
| image.tag | string | `nil` | Overrides the image tag used |
| nameOverride | string | `""` | Overrides the name of resources |
| nodeSelector | object | `{}` | Node Selector configuration |
| podSecurityContext | object | `{}` | Set Pod security contexts |
| replicaCount | int | `1` | Number of pods to run |
| resources | object | `{}` | Set resource limits/requests for the Pod(s) |
| securityContext | object | `{}` | Set Security Context |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| storageClass.annotations | object | `{}` | (Optional) annotations to add to the StorageClass. ie. `storageclass.kubernetes.io/is-default-class: "true"` |
| storageClass.reclaimPolicy | string | `"Delete"` | Reclaim Policy to use for created PVCs |
| storageClass.serverSecretNamespace | string | `nil` | Overrides the namespace of the secret which contains the FreeNAS server connection details. Default is this Release's Namespace |
| storageClass.parameters.datasetParentName | string | `"tank"` | the name of the parent dataset (or simply pool) where all resources will be created, it *must* exist before provisioner will work. ie tank/k8s/mycluster |
| storageClass.parameters.datasetEnableQuotas | string | `"true"` | whether to enforce quotas for each dataset. If enabled each newly provisioned dataset will set the appropriate quota per the PVC |
| storageClass.parameters.datasetEnableReservation | string | `"true"` | whether to reserve space when the dataset is created. If enabled each newly provisioned dataset will set the appropriate value per the PVC |
| storageClass.parameters.datasetEnableNamespaces | string | `"true"` | if enabled provisioner will create parent datasets for each namespace otherwise, all datasets will be provisioned in a flat manner |
| storageClass.parameters.datasetNamespaceQuota | string | `nil` | Sets a per-namespace quota. example: 5M | 10G | 1T  (M, Mi, MB, MiB, G, Gi, GB, GiB, T, Ti, TB, or TiB). datasetEnableNamespaces must also be set to `true` |
| storageClass.parameters.datasetNamespaceReservation | string | `nil` | Sets a per-namespace reservation. Should not be greater than the `datasetNamespaceQuota`. datasetEnableNamespaces must also be set to `true`. example: 5M | 10G | 1T  (M, Mi, MB, MiB, G, Gi, GB, GiB, T, Ti, TB, or TiB). |
| storageClass.parameters.datasetDeterministicNames | string | `"true"` | if enabled created datasets will adhere to reliable pattern. if datasetNamespaces == true dataset pattern is: <datasetParentName>/<namespace>/<PVC Name>. if datasetNamespaces == false dataset pattern is: <datasetParentName>/<namespace>-<PVC Name>. if disabled, datasets will be created with a name pvc-<uid> (the name of the provisioned PV). |
| storageClass.parameters.datasetRetainPreExisting | string | `"true"` | if enabled and datasetDeterministicNames is enabled then dataset that already exist (pre-provisioned out of band) will be retained by the provisioner during deletion of the reclaim process ignored if datasetDeterministicNames is disabled (collisions result in failure) |
| storageClass.parameters.datasetPermissionsGroup | string | `"wheel"` | Sets group of the dataset mount directory (on FreeNAS) immediately upon creation |
| storageClass.parameters.datasetPermissionsMode | string | `"0777"` | Sets chmod of the dataset mount directory (on FreeNAS) immediately upon creation |
| storageClass.parameters.datasetPermissionsUser | string | `"root"` | Sets user of the dataset mount directory (on FreeNAS) immediately upon creation |
| storageClass.parameters.shareHost | string | `nil` | Determines what the 'server' property of the NFS share will be in kubernetes. Its purpose is to provide flexibility between the control and data planes of FreeNAS. If not set, uses the 'host' value from the secret. |
| storageClass.parameters.shareAlldirs | string | `"true"` | Determines if newly created NFS shares will have the 'All Directories' option checked - note that some k8s versions (e.g OKD 3.11 which has v1.11.0 under the hood) may demand Strings as in "true" or "false". |
| storageClass.parameters.shareAllowedHosts | string | `""` | Authorized hosts (space-separated) allowed to access the shares. All by default. |
| storageClass.parameters.shareAllowedNetworks | string | `""` | Authorized hosts/networks (space-separated) allowed to access the shares. All by default. |
| storageClass.parameters.shareMaprootGroup | string | `"wheel"` | Determines root group mapping. NOTE: cannot be used simultaneously with shareMapAll{User,Group} |
| storageClass.parameters.shareMaprootUser | string | `"root"` | Determines root user mapping. NOTE: cannot be used simultaneously with shareMapAll{User,Group} |
| storageClass.parameters.shareMapallUser | string | `nil` | Determines user mapping for all access (not recommended). NOTE: cannot be used simultaneously with shareMaproot{User,Group} |
| storageClass.parameters.shareMapallGroup | string | `nil` | Determines group mapping for all access (not recommended. NOTE: cannot be used simultaneously with shareMaproot{User,Group} |
| storageClass.parameters.shareRetainPreExisting | string | `"true"` | if enabled and datasetDeterministicNames is enabled then shares that already exist (pre-provisioned out of band) will be retained by the provisioner during deletion of the reclaim process ignored if datasetDeterministicNames is disabled (collisions result in failure) |
| tolerations | list | `[]` | Node toleration configuration |

## K3s Notes

If running on K3s and you would like to make this the default StorageClass, follow these steps:

1) Disable `local-path` as the default *StorageClass*
```sh
$ kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
```
2) Set the following in your `values.yaml`
```yaml
storageClass:
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
```

## Futher Reading

For further information, see the [nmaupu/freenas-provisioner](https://github.com/nmaupu/freenas-provisioner) project.