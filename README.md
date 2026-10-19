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

Once the changes in `next/` are ready, publish them with `release` (see below).

Re-running `./prepare` on a project that already has a `next` folder fails to avoid
overwriting work in progress; pass `-f`/`--force` to discard it and start over.

## Create a release

Use the `release` script once the `next` folder is ready. It takes the project and the
upgrade level (`major`, `minor` or `patch`, case-insensitive):

```sh
./release wegas minor   # v2.1.4 -> v2.2.0
./release colab patch   # v2.2.1 -> v2.2.2
```

The script:

1. computes the new version from the latest `vX.Y.Z` folder and the upgrade level,
2. moves `next/` to the new version folder and sets `version` in its `Chart.yaml`,
3. packages the chart (`<project>-<version>.tgz` at the repo root) and updates `index.yaml`,
4. runs `prepare` to create a fresh `next/` from the new release.

It requires `helm` and an existing `next/` folder (run `./prepare <project>` first).
Then review the changes, `git commit` the new version folder, the `.tgz`, `index.yaml`
and `next/`, and `push`.

## Rebuild packages and index

### example for colab 1.0

```sh
helm package charts/coLAB/v1.0.0/
helm repo index .
```

then `git commit index.yaml colab-1.0.0.tgz` and `push`.
