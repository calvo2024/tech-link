podman build -t oss-vault .

vault server -dev -dev-listen-address=0.0.0.0:8200


https://podman-desktop.io/docs/kubernetes/configuring-editing-kube-object
https://kubernetes.io/docs/concepts/storage/volumes/#hostpath-fileorcreate-example

podman network ls

podman run -d -p 8080:80 --network podman-default-kube-network --name bastion oss-vault
podman exec -it bastion bash

apt install -y nginx nano

nano /etc/nginx/sites-available/default
```
location / {
            proxy_pass http://pod1:8200;
}
```