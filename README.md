# albasim-catalog

Helm catalog
 * wegas 
 * colab
 * grafana-backup

## Rebuild packages and index

### example for colab 1.0

```sh
helm package charts/coLAB/v1.0.0/
helm repo index .
```

then `git commit index.yaml colab-1.0.0.tgz` and `push`.

## Rancher leftovers

`questions.yaml` and `app-readme.md` were Rancher catalog files. Rancher is gone --
do not recreate them when copying a chart folder for a new version.
