# k8x
Kubernetes Export (For env diffing)
Depends on yq and jq 

```
brew install yq jq
```

### WTF is this?
We needed a script to quickly dump kubernetes configmaps, deployments, services, and ingresses in a diff ready form. That's what this basically does.

[test_run.sh](test_run.sh) - this has an example of how it can be used with two environments, one named helium, the other saturn. It also shows how to compare using *Beyond Compare*

Configmaps are still the hardest to clean up, but we've gone as far as making sure the keys are sorted for you so any diff tool will have an easy time pointing out anything missing. 