# albasim-catalog

Helm catalog
 * wegas 
 * colab
 * grafana-backup

## Prepare a new release

After packaging a new release (before `git commit`/`git push`), use the `prepare` script to copy this latest version folder of a chart into a `next` folder. That way, next time we modify (the next folder) for a new release, we can have viable diffs instead of new files we can't `git diff`.

```sh
./prepare wegas
./prepare colab
```

The project name is case-insensitive. Edit the chart under `next/` (bump `Chart.yaml`,
update templates/values, etc.) — since it starts as an exact copy of the last release,
`git diff charts/<project>/next` shows exactly what changed for the new version.

Once the release is ready, rename `next/` to the new version folder (e.g. `v2.1.5/`)
before packaging (see below).

Re-running `./prepare` on a project that already has a `next` folder fails to avoid
overwriting work in progress; pass `-f`/`--force` to discard it and start over.

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
