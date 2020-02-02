# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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