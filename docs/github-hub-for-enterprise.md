# Setting up GitHub Hub for Enterprise

The confusing part is the `GITHUB_HOST` vs the whitelisting with `git config --global --add hub.host MY.GIT.ORG`. It goes like this:

`hub` is able to infer what HOST it should use for git operations, from the `git remote` output. We only need to whitelist said HOST.

From this point onwards, for operations like `clone` or `init`, it will default to `github.com`. If we want to clone an Enterprise one, we need to run it like `GITHUB_HOST=my.github.org git clone user/repo`.

THE PROBLEM is that once that's done, operations like `git pull-request` or such requires the API token. If we use both Cloud & Enterprise, we'll need to switch the access token before operations.


So, instead of whitelisting, this is my aproach:

```bash
useCloudGitHub() {
    export GITHUB_TOKEN=token
    export GITHUB_HOST=github.com
}
useEnterpriseGitHub() {
    export GITHUB_TOKEN=token
    export GITHUB_HOST=my.github.org
}
```

Then we just call the bash function as soon as we enter the repo. Since we're explicitly setting the `GITHUB_HOST`, we don't need to whitelist anything.p
