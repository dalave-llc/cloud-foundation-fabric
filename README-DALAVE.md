# Dalave terraform modules

Fork the following repository:

https://github.com/GoogleCloudPlatform/cloud-foundation-fabric.git

Forked repository will have `master` as branch default branch. This branch will be used to fetch any updates from Google. We are never going to commit to this branch.

Clone the repository to your local and add upstream as follows:

```
git remote add upstream https://github.com/GoogleCloudPlatform/cloud-foundation-fabric.git
```

Add another branch as `main`

```
git checkout -b main
git commit -m "feat: internal main branch" .
```

This is the branch that can be used for any modifications or customizations to the modules.

## Releasing modules

### Fetch only the specific tag (v58.0.0) from Google without importing all historical tags:

```
git fetch upstream tag v58.0.0 --no-tags
```

Create working branch from that tag:

```
git checkout -b internal-v58.0.0 v58.0.0
```

Verification: Run `git log -1 --oneline`. The top commit will match Google's official release commit for v58.0.0.

Make your edits to the modules, then stage and commit them

```
git add modules/
git commit -m "feat: add initial readme for dalave"
```

### Create your custom tag

Following will be the naming convention we will be using so that we can identify which Google release maps to our release:

`<Google Release>-<companyslog>-version`

example:
v58.0.0-dalave.1.0.0 - This is dalave's first version of terraform modules.

```
git tag -a v58.0.0-dalave.1.0.0 -m "CFF v58.0.0 with internal first version 1.0.0"
```

Verification: Run `git tag -l "v58.0.0-dalave*"`. You should see v58.0.0-dalave.1.0.0 listed.

### Push Your Branch and Custom Tag to Origin

```
git push --set-upstream origin internal-v58.0.0
git push origin v58.0.0-dalave.1.0.0
```