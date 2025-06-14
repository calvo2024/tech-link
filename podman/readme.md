prepare yaml's and certs

```bash
./init.sh
```

to start your cluster

```bash
podman kube play pods.yaml
```

to stop your cluster

```bash
podman kube down pods.yaml
```

to use vault
```bash
podman exec -it pod1-oss-vault bash
```