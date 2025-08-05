podman build -t tl-ubuntu ../tl-ubuntu
podman build -t tl-boundary tl-boundary
podman build -t tl-sshd tl-sshd

cat pods.yaml.template | sed "s+__ENTER__PWD__HERE__+$PWD+g" > pods.yaml

podman kube play pods.yaml

podman logs intermediate-worker | head
podman logs egress-worker | head
