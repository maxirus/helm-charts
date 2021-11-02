# bitwarden-rs

![Version: 0.5.0](https://img.shields.io/badge/Version-0.5.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.23.0](https://img.shields.io/badge/AppVersion-1.23.0-informational?style=flat-square)

A Helm chart to deploy Bitwarden_RS and the MySQL backend

This Helm Chart deploys the [dani-garcia/bitwarden_rs](https://github.com/dani-garcia/bitwarden_rs) project, using the MySQL backend, into your Kubernetes cluster. It provides a secure, central password management utility.

**Homepage:** <https://github.com/maxirus/helm-charts/tree/master/charts/bitwarden-rs>

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

## Source Code

* <https://github.com/maxirus/helm-charts/tree/master/charts/bitwarden-rs>
* <https://github.com/dani-garcia/bitwarden_rs>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-charts.storage.googleapis.com/ | mysql | 1.6.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Set Pod affinity rules |
| bitwardenConfig.data_folder | string | `"/data"` | parent directory for all Bitwarden persisted data. [Docs](https://github.com/dani-garcia/bitwarden_rs/wiki/Changing-persistent-data-location#data-prefix) |
| bitwardenConfig.log_level | string | `"info"` | Sets the LOG_LEVEL. [Docs](https://github.com/dani-garcia/bitwarden_rs/wiki/Logging#change-the-log-level) |
| bitwardenConfig.show_password_hints | bool | `false` | Enables the display of Password Hints instead of sending via email. It is recommended to leave this disabled. [Docs](https://github.com/dani-garcia/bitwarden_rs/wiki/Password-hint-display) |
| bitwardenConfig.web_vault_enabled | bool | `true` | Enables the Web Valut (UI) interface. [Docs](https://github.com/dani-garcia/bitwarden_rs/wiki/Disabling-or-overriding-the-Vault-interface-hosting) |
| credentials.secretName | string | `"bitwarden"` | name of the secret which contains Bitwarden Admin token and DB Password. NOTE: if you change this you must also change mysql.existingSecret to match. |
| credentials.useExistingSecret | bool | `false` | Set this to true to use your own Secret, created outside of this deployment. Expects `adminToken`, `mysql-password`, and `mysql-root-password`. |
| credentials.yubicoSecretKey | string | `""` | Key used in `credentials.secretName` that contains your Yubico Secret Key. [Docs](https://github.com/dani-garcia/bitwarden_rs/wiki/Enabling-Yubikey-OTP-authentication) |
| fullnameOverride | string | `""` | Overrides the Full Name of resources |
| image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| image.pullSecrets | list | `[]` | Secrets to use when pulling Docker images |
| image.repository | string | `"vaultwarden/server"` | Docker registry/repository to pull the image from |
| image.tag | string | `nil` | Overrides the image tag used |
| ingress.annotations | object | `{}` | annotations to configure your Ingress. See your Ingress Controller's Docs for more info. |
| ingress.enabled | bool | `false` | Enables the use of an Ingress Controller to front the Service and provide HTTPS |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":["/"]}]` | list of hosts and their paths that ingress controller should repsond to. First host will be used to set the Bitwarden `DOMAIN`. |
| ingress.tls | list | `[]` | list of TLS configurations |
| mysql | object | `{"enabled":true,"existingSecret":"bitwarden","externalHost":null,"mysqlDatabase":"bitwarden","mysqlUser":"bitwarden","service":{"port":3306}}` | MySQL HelmChart configuration options. See [docs](https://github.com/helm/charts/tree/master/stable/mysql) |
| mysql.enabled | bool | `true` | Set to `false` to skip MySQL deployment and use and external instance. Must also set `mysql.externalHost`. |
| mysql.existingSecret | string | `"bitwarden"` | Secret to reference for MySQL credentials |
| mysql.externalHost | string | `nil` | Sets an external host to use instead of the included MySQL chart dependency. Must also set `mysql.enabled: false`. |
| mysql.mysqlDatabase | string | `"bitwarden"` | Database name for Bitwarden |
| mysql.mysqlUser | string | `"bitwarden"` | Username Bitwarden should use |
| mysql.service.port | int | `3306` | Port MySQL should use for connections |
| nameOverride | string | `""` | Overrides the name of resources |
| nodeSelector | object | `{}` | Node Selector configuration |
| persistence.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.annotations | object | `{}` | (Optional) annotations to add to the PVC |
| persistence.enabled | bool | `false` | Enables persistence of the Bitwarden_rs `/data` directory |
| persistence.size | string | `"8Gi"` | size/capacity of the PVC |
| podSecurityContext | object | `{}` | Set Pod security contexts |
| replicaCount | int | `1` | Number of pods to run. >1 has NOT been tested |
| resources | object | `{}` | Set resource limits/requests for the Pod(s) |
| securityContext | object | `{}` | Set Security Context |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| tolerations | list | `[]` | Node toleration configuration |

## Using an external MySQL Database

To use an external MySQL Database and **not** deploy the included MySQL sub-chart, set the following:
```yaml
mysql:
  enabled: false
  externalHost: mysql.domain.tld
```

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
