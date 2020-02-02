# Bitwarden_rs

This Helm Chart deploys the [dani-garcia/bitwarden_rs](https://github.com/dani-garcia/bitwarden_rs) project, using the MySQL backend, into your Kubernetes cluster. It provides a secure, central password management utility.

## Install

Using [Helm](https://helm.sh), you can easily install and test Bitwarden_rs in a 
Kubernetes cluster by running the following:

```
helm upgrade --install \
  my-release
  maxirus/bitwarden-rs \
```

**NOTE:**
- For *production* installs, it is highly-recommended to configure persistence, SSL, passwords, etc. See configuration values below.
- Depending on your browser, you will most likely need to setup HTTPS (See `ingress` below)

## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-charts.storage.googleapis.com/ | mysql | 1.6.2 |

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Set Pod affinity rules |
| credentials.secretName | string | `"bitwarden"` | name of the secret which contains Bitwarden Admin token and DB Password. NOTE: if you change this you must also change mysql.existingSecret to match. |
| credentials.useExistingSecret | bool | `false` | Set this to true to use your own Secret, created outside of this deployment. Expects `adminToken`, `mysql-password`, and `mysql-root-password`. |
| fullnameOverride | string | `""` | Overrides the Full Name of resources |
| image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| image.pullSecrets | list | `[]` | Secrets to use when pulling Docker images |
| image.repository | string | `"bitwardenrs/server-mysql"` | Docker registry/repository to pull the image from |
| ingress.annotations | object | `{}` | annotations to configure your Ingress. See your Ingress Controller's Docs for more info. |
| ingress.enabled | bool | `false` | Enables the use of an Ingress Controller to front the Service and provide HTTPS |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":["/"]}]` | list of hosts and their paths that ingress controller should repsond to. |
| ingress.tls | list | `[]` | list of TLS configurations |
| mysql | object | | MySQL HelmChart configuration options. See [docs](https://github.com/helm/charts/tree/master/stable/mysql) |
| mysql.existingSecret | string | `"bitwarden"` | Secret to reference for MySQL credentials |
| mysql.mysqlDatabase | string | `"bitwarden"` | Database name for Bitwarden |
| mysql.mysqlUser | string | `"bitwarden"` | Username Bitwarden should use |
| nameOverride | string | `""` | Overrides the name of resources |
| nodeSelector | object | `{}` | Node Selector configuration |
| persistence.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.annotations | object | `{}` | (Optional) annotations to add to the PVC |
| persistence.enabled | bool | `false` | Enables persistence of the Bitwarden_rs `/data` directory |
| persistence.size | string | `"8Gi"` | size/capacity of the PVC |
| persistence.storageClass | string | `nil` | (Optional) StorageClass to use for the PVC |
| podSecurityContext | object | `{}` | Set Pod security contexts |
| replicaCount | int | `1` | Number of pods to run. >1 has NOT been tested |
| resources | object | `{}` | Set resource limits/requests for the Pod(s) |
| securityContext | object | `{}` | Set Security Context |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | (Optional) name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | Node toleration configuration |

## Security Concerns

1. Although traffic from you browser to the ingress endpoint is encrypted, the traffic being proxied from the 
ingress to the web service is **NOT** by default. You must use the `ROCKET_TLS` environment variable or use a service mesh like LinkerD.
2. Communication between the Web Service and MySQL is **NOT** encrypted by default. Follow the ssl configuration docs found [here](https://github.com/helm/charts/tree/master/stable/mysql#configuration).
3. Making this service Publicly accessible to the internet is a bad idea. Use a VPN instead.

## Further Reading

Checkout the [dani-garcia/bitwarden_rs](https://github.com/dani-garcia/bitwarden_rs) project for more details on Bitwarden_rs.

These Docs are not meant to be comprehensive in nature. You should fully understand the security aspects of running your own 
central password management service before using this. I'd highly recommend using the [Official Bitwarden](https://bitwarden.com) service instead 
if you have any doubts. 