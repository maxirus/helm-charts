# Helm Charts

This GitHub project hosts my custom Helm Charts as a repository. If you're looking for the Official Helm repository, you can find it [here](https://github.com/helm/charts).

This repository hosts `apiVersion: v2` charts only (Helm v3).

## Setup

```
$ helm repo add maxirus https://maxirus.github.io/helm-charts/
```

## Chart Install

```
$ helm upgrade --install <release_name> maxirus/<chart_name>
```

## Charts

- [freenas-provisioner](freenas-provisioner/)
- [Bitwarden_rs](bitwarden_rs/)
- [Jellyfin](jellyfin/)