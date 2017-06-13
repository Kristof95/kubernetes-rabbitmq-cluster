> Rabbit MQ as a stateful set in kubernetes

__This image is _not_ suitable unless running as a stateful set in kubernetes.__

[Docker Hub](https://hub.docker.com/r/advinans/k8s-rabbitmq/)

### Usage

Rename `secrets.yaml.example` to `secrets.yaml` and add the corresponding secrets. `cookie` will be used as a erlang cookie, `user` and `pass` will be used as credentials for Rabbit MQ. Now you can proceed and deploy each of the files.

If you are __not__ using `RBAC` you should not deploy the `service-account.yaml` and `role-and-role-binding.yaml` files. Also make sure to remove `serviceAccountName` from the `stateful-set.yaml`-file.

The stateful-set contains a `kubectl` sidecar proxy that it uses to communicate with the kubernetes API to retrieve the stateful-set data when joining.

#### Notes
This project is based upon [kubernetes-rabbitmq-cluster](https://github.com/nanit/kubernetes-rabbitmq-cluster) and [this blog post](https://wesmorgan.svbtle.com/rabbitmq-cluster-on-kubernetes-with-statefulsets).