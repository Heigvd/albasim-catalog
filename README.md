# albasim-catalog

Rancher Helm catalog
 * wegas-war-manager
 * wegas 
 * colab

## Rebuild packages and index

### example for colab 1.0

```sh
helm package charts/coLAB/v1.0.0/
helm repo index .
```

then `git commit index.yaml colab-1.0.0.tgz` and `push`.
