# Tsuru Helm Charts

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add tsuru https://tsuru.github.io/charts
```

You can then run `helm search repo tsuru` to see the charts.

Charts are also published as OCI artifacts to GitHub Container Registry, so they can be installed without adding the repo:

```console
helm install tsuru-api oci://ghcr.io/tsuru/charts/tsuru-api --version <VERSION>
```
