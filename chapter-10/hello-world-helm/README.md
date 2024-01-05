# HelloWorld App Helm Chart

## Introduction

This Helm chart deploys a 3-tier web application on a Kubernetes cluster using the Helm package manager. The application consists of a backend, a frontend, and a MongoDB database.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `my-release` for production:

```bash
helm install my-release ./hello-world -f values-production.yaml
```

To install for staging:

```bash
helm install my-release ./hello-world -f values-staging.yaml
```

## Configuration

The following table lists the configurable parameters of the hello-world chart and their default values, as per `values-production.yaml` and `values-staging.yaml`.

### Common Configuration Parameters

| Parameter                 | Description                         | Default                  |
|---------------------------|-------------------------------------|--------------------------|
| `backend.replicaCount`    | Number of backend replicas          | `1`                      |
| `backend.image.repository`| Backend image repository            | `<Artifactory Server IP Address>/docker-local/backend`|
| `backend.image.tag`       | Backend image tag                   | `<Docker Image Tag>`                |
| `backend.image.pullPolicy`| Backend image pull policy           | `IfNotPresent`           |
| `backend.service.type`    | Backend service type                | `ClusterIP`              |
| `backend.service.port`    | Backend service port                | `3000`                   |
| `frontend.replicaCount`   | Number of frontend replicas         | `1`                      |
| `frontend.image.repository`| Frontend image repository          | `<Artifactory Server IP Address>/docker-local/frontend`|
| `frontend.image.tag`      | Frontend image tag                  | `<Docker Image Tag>`                |
| `frontend.image.pullPolicy`| Frontend image pull policy         | `IfNotPresent`           |
| `frontend.service.type`   | Frontend service type               | `ClusterIP`              |
| `frontend.service.port`   | Frontend service port               | `80`                     |
| `mongodb.replicaCount`    | Number of MongoDB replicas          | `1`                      |
| `mongodb.image.repository`| MongoDB image repository            | `mongo`                  |
| `mongodb.image.tag`       | MongoDB image tag                   | `latest`                 |
| `mongodb.image.pullPolicy`| MongoDB image pull policy           | `IfNotPresent`           |
| `mongodb.service.type`    | MongoDB service type                | `ClusterIP`              |
| `mongodb.service.port`    | MongoDB service port                | `27017`                  |
| `mongodb.persistence.enabled` | Enable MongoDB persistence       | `true`                   |
| `mongodb.persistence.storageSize` | MongoDB storage size         | `10Gi`                   |

### Installing for Different Environments

Specify the `values` file corresponding to the desired environment:

- For Production:

```bash
helm install my-release ./hello-world -f values-production.yaml
```

- For Staging:

```bash
helm install my-release ./hello-world -f values-staging.yaml
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm delete my-release
```

This removes all the Kubernetes components associated with the chart and deletes the release.

## Additional Information

For more information about the chart and its configuration, refer to the `values-production.yaml`, `values-staging.yaml`, and `Chart.yaml` files.