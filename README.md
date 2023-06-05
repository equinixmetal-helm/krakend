# Krakend

![Version: 0.1.17](https://img.shields.io/badge/Version-0.1.17-informational?style=for-the-badge)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=for-the-badge)
![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=for-the-badge)

This is a helm chart that deploys a [Krakend](https://www.krakend.io/) instance.

## Description

A Helm chart for deploying krakend.io in Kubernetes provided
and maintained by your friends at Equinix Metal

## Installation

* Add the Equinix Metal helm repository
```bash
helm repo add equinixmetal https://helm.equinixmetal.com
```

* Install the helm chart using default values
```bash
helm install krakend equinixmetal/krakend
```

> If you are using your own chart, reference the following to your chart's dependencies:
> ```yaml
> dependencies:
>   - name: krakend
>     version: v0.1.16
>     repository: "https://helm.equinixmetal.com"
> ```

## Usage

There are two main modes of operation:

* configMap-based: the configuration is stored in a configMaps and mounted in the
  container.

* all-in-one image: the configuration is stored in the container image itself.

Note that the all-in-one image method assumes that the configuration is stored
in the `/etc/krakend-src/config` path. This is done to allow for mounting
the license as describe in the section below.

Both modes of operation enable the flexible configuration feature. For the all-in-one
image, this is done so that the configuration can take environment variables into use.

Note that for a further description on how to use partials, settings and templates,
please refer to [the official krakend documentation](https://www.krakend.io/docs/configuration/flexible-config/).

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | The affinity to use for the krakend pod |
| deploymentType | string | `"deployment"` | The deployment type to use for the krakend service Valid values are `deployment` and `rollout` |
| extraVolumeMounts | array | `[]` | extraVolumeMounts allows you to mount extra volumes to the krakend pod |
| extraVolumes | array | `[]` | extraVolumes allows you to mount extra volumes to the krakend pod |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | The image pull policy to use |
| image.registry | string | `"docker.io"` | The image registry to use |
| image.repository | string | `"devopsfaith/krakend"` | The image repository to use |
| image.tag | string | `"2.3.3"` | The image tag to use |
| imagePullSecrets | list | `[]` | List of secrets containing the credentials to use for the image |
| ingress | object | `{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}],"tls":[]}` | The ingress settings to use for the krakend ingress |
| ingress.annotations | object | `{}` | The annotations to use for the ingress |
| ingress.className | string | `""` | The class to use for the ingress |
| ingress.enabled | bool | `false` | Specifies whether an ingress should be created |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]` | The list of hosts to use for the ingress |
| krakend.allInOneImage | bool | `false` | Whether the given krakend image to be used contains everything needed for the krakend service to run. If set to false, the image will be used as a base image and the configuration will be loaded from the configmap. Note that the all-in-one image assumes the krakend configuration is located at /etc/krakend-src/config/krakend.tmpl |
| krakend.config | string, optional | `""` | If set, this key will contain the full configuration of the krakend service |
| krakend.env | array | `[]` | The environment variables to use for the krakend container. The default is just the ones needed to enable flexible configuration. |
| krakend.extraConfig | object | `{"router":{"@comment":"The health endpoint checks do not show in the logs","logger_skip_paths":["/__health"]}}` | The service-level "extra_config" settings. This will directly be translated to JSON and is added only if you're not fully overriding the configuration via the `config` setting. For more information, see https://www.krakend.io/docs/enterprise/configuration/ |
| krakend.partials | Object | `{"endpoints.tmpl":"[\n  {\n    \"endpoint\": \"/test\",\n    \"method\": \"GET\",\n    \"backend\": [\n        {\n            \"method\": \"GET\",\n            \"host\": [],\n            \"url_pattern\": \"/__debug/roots\",\n            \"encoding\": \"json\",\n            \"deny\": [\n                \"message\"\n            ]\n        }\n    ],\n    \"extra_config\": {\n        \"proxy\": {\n            \"static\": {\n                \"data\": {\n                    \"collection\": [\n                        {\n                            \"directories\": [\n                                \"Graceland\"\n                            ]\n                        }\n                    ],\n                    \"version\": \"deficient\"\n                },\n                \"strategy\": \"always\"\n            }\n        }\n    },\n    \"output_encoding\": \"json\"\n  }\n]","input_headers.tmpl":"\"input_headers\": [\n  \"Content-Type\",\n  \"ClientId\"\n]","rate_limit_backend.tmpl":"\"qos/ratelimit/proxy\": {\n  \"max_rate\": 0.5,\n  \"capacity\": 1\n}"}` | The default configuration has a partials files that will be used to load several aspects of the configuration. If you want to include expra partials, add or remove them here. |
| krakend.settings | object | `{"service.json":"{\n\t\"environment\": \"PRODUCTION\",\n\t\"default_host\": \"http://localhost:8080\",\n\t\"timeout\": \"3s\",\n\t\"cache_ttl\": \"3s\",\n\t\"output_encoding\": \"json\"\n}"}` | The default configuration has a settings files that will be used to load several aspects of the configuration. |
| krakend.templates | object | `{}` | While default configuration does not take into use templates; you may want to add your own templates here. Note that you'd need to set a custom configuration file to use them. |
| livenessProbe | object | `{"httpGet":{"path":"/__health","port":"http"}}` | The livenessProbe to use for the krakend pod |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | The nodeSelector to use for the krakend pod |
| podAnnotations | object | `{}` | The annotations to use for the krakend pod |
| podSecurityContext | object | `{}` | The securityContext to use for the krakend pod |
| readinessProbe | object | `{"httpGet":{"path":"/__health","port":"http"}}` | The readinessProbe to use for the krakend pod |
| replicaCount | int | `1` | Number of replicas to deploy |
| resources | object | `{}` | The resources to use for the krakend pod |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"add":["NET_BIND_SERVICE"],"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true,"runAsUser":1000}` | The securityContext to use for the krakend container |
| service | object | `{"annotations":{},"externalTrafficPolicy":"","port":80,"targetPort":8080,"type":"ClusterIP"}` | The service settings to use for the krakend service |
| service.annotations | object | `{}` | The annotations to use for the service |
| service.externalTrafficPolicy | string | `""` | The External Traffic Policy of the service |
| service.port | int | `80` | The port to use for the service |
| service.targetPort | int | `8080` | The target port to use for the service |
| service.type | string | `"ClusterIP"` | The type of service to use |
| serviceAccount.annotations | object | `{}` | The annotations to use for the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceMonitor | object | `{"annotations":{},"enabled":false,"interval":"10s","scrapeTimeout":"10s","targetPort":9091}` | The serviceMonitor configures a ServiceMonitor for your application |
| serviceMonitor.annotations | object | `{}` | Annotations to add to ServiceMonitor |
| serviceMonitor.enabled | bool | `false` | Set to true to create a default ServiceMonitor for your application |
| serviceMonitor.interval | string | `"10s"` | Interval for scrape metrics. |
| serviceMonitor.scrapeTimeout | string | `"10s"` | time out interval when scraping metrics |
| serviceMonitor.targetPort | int | `9091` | prometheus metrics port exposed by krakend |
| strategy | object | `{}` | The strategy for the krakend deployment. This can either be a `deployment` or a `rollout` strategy. For more information on the Argo Rollout strategy, see https://argo-rollouts.readthedocs.io/en/stable/features/specification/ |
| tolerations | object | `[]` | The tolerations to use for the krakend pod |

## Development

### Prerequisites

- [helm](https://helm.sh/docs/intro/install/)
- [helm-docs](https://github.com/norwoodj/helm-docs)

### Testing

Ensure that the documentation is up to date before pushing a pull request:

```bash
helm-docs
```

### Releasing

There is a useful Makefile target that's useful to cut a release. So, simply do:

```bash
TAG=$RELEASE_VERSION make release
```

And the release will happen.

Note that this project follows the [Semantic Versioning scheme](https://semver.org/), so
make sure to follow it when cutting releases.

The `TAG` Makefile variable takes a release version without the `v` prefix. For example,
if you want to cut a release with version `v1.2.3`, you'd do:

```bash
TAG=1.2.3 make release
```

# Using Krakend.io Enterprise

Krakend.io Enterprise is a commercial product that extends the capabilities
of the open source Krakend.io API Gateway. It is available as a Docker image
that can be used as a drop-in replacement for the open source image.

In order to configure the helm chart to use it, you'd need a values file similar
as the following:

```yaml
image:
  registry: docker.io
  repository: krakend/krakend-ee
  tag: "2.1.2"
extraVolumeMounts:
  - name: license
    mountPath: /etc/krakend/LICENSE
    readOnly: true
extraVolumes:
  - name: license
    secret:
      secretName: krakend-license
```

Note the mount of the license file in the `/etc/krakend/LICENSE` path.
