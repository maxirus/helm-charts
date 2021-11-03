# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.5.0] - 2021-11-02
### Updated
- Bitwarden_rs renamed to vaultwarden. Changed Image repo accordingly
- application version to `v1.23.0`
- MySQL chart version to `v1.6.9`
### Fixed
- MySQL Chart repo

## [0.4.1] - 2020-05-11
### Fixed
- Bitwarden_rs `v1.14` now expects `DOMAIN` to be a full URL 

## [0.4.0] - 2020-05-10
### Added
- Option to override the Docker image tag used via value `image.tag`
### Updated
- Bitwarden-rs to `v1.14.2`

## [0.3.0] - 2020-02-04
### Added
- [Feature #1](https://github.com/maxirus/helm-charts/issues/1) Support for the use of an external MySQL database

## [0.2.0] - 2020-02-02
### Added
- Common Bitwarden Configurations
- Now able to inject custom Bitwarden_rs configurations via `bitwardenConfig`
- `DOMAIN` now set when given an Ingress Host
- `data` directory now configurable
- YubiKey now configurable and client secret is stored in the defined Kubernetes Secret
### Updated
- Docs
### Fixed
- Password hints now disabled by default for added security

## [0.1.0] - 2020-01-31
### Added
- Initial Chart