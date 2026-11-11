# albasim-catalog

Helm catalog
 * wegas
 * colab

## New version procedure summary
Always edit the `next` folder so that the diff is readable for the reviewer.

- If the `next` folder is missing, run `./prepare <project>` and commit the changes
- Edit the `next` folder of the target project (wegas|colab)
- Run the [release script](#create-a-release)
- Commit all the changes
  - `next` changes
  - the new chart folder
  - the new .tgz
  - index.yaml

## Prepare the next release
This script is normally run automatically at the end of the [`release` script](#create-a-release). Run it only if the `next` folder is missing for the project(s) you are releasing.

This script makes a copy of the latest version folder and renames it to `next`.

```sh
./prepare wegas
./prepare colab
```

The project name is case-insensitive.

Running `./prepare` on a project that already has a `next` folder will abort to avoid
overwriting work in progress; pass `-f`/`--force` to discard it and start over.

## Create a release

Use the `release` script once the `next` folder is ready. It takes the project and the
upgrade level (`major`, `minor` or `patch`, case-insensitive):

```sh
./release wegas minor   # v2.1.4 -> v2.2.0
./release colab patch   # v2.2.1 -> v2.2.2
```

The script does the following

1. computes the new version from the latest `vX.Y.Z` folder and the upgrade level
2. moves `next/` to the new version folder and sets `version` in its `Chart.yaml`
3. packages the chart (`<project>-<version>.tgz` at the repo root) and updates `index.yaml`
4. runs `prepare` to create a fresh `next/` from the new release

It requires `helm` and an existing `next/` folder (if missing, run `./prepare <project>` first).
Then review the changes, `git commit` the new version folder, the `.tgz`, `index.yaml`
and `next/`, and `push`.

## Rebuild packages and index by hand
Use this if you need to package a chart and regenerate `index.yaml` yourself, without the `release` script, so the chart is published in the Helm repository.

### Example for colab 1.0

```sh
helm package charts/coLAB/v1.0.0/
helm repo index .
```

then `git commit index.yaml colab-1.0.0.tgz` and `push`.
