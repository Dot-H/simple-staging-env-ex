# simple-staging-env-ex

This repository is an example about how I developed a simple staging
environment at [eKee](https://ekee.io).

The whole process is explained in [this article](https://www.alx-b.com/blog/engineering/startup-staging-env)
published on my website: [alx-b.com](https://alx-b.com).

Feel free to fork it and extend it as you want :)

# Running the example locally

In order to run the example locally you will need to install:

- [minikube](https://kubernetes.io/fr/docs/setup/learning-environment/minikube/)
- [helm](https://helm.sh/docs/intro/quickstart/)

```bash
cd k8s/staging-env
minikube start
minikube addons enable ingress

sleep 2 # Gives time to ingress to get ready

# Deploy normal environment
helm install echo-server .

# Deploy staging environment
helm install staging-echo-server . --values values-staging.yaml
```

The example uses the staging image built from [PR #3](https://github.com/Dot-H/simple-staging-env-ex/pull/3)
