# Pyspark-Notebook

For this we have built web application in docker container using Pyspark and integrated it with Jupyter-Notebook.

## Prerequisites

1. [Install Docker](https://github.com/pranshujain22/Hadoop/blob/master/Docker/Installation.md).

2. Pull Docker image from docker hub repositories
```shell
  $ docker pull pranshujain/pyspark-notebook:<version>
```

## For Local Use


After completing prerequisites simply run the following commands:

```shell
$ docker run -it --name <container-name> pranshujain/pyspark-notebook:<version>
```

Check for container's IPAddress(e.g. "IPAddress": "172.17.0.2") using following command:
```shell
$ docker inspect <container-name>
```

Start the web browser and enter IPAddress in the following pattern,
> \<IPAddress\>:8888

as the 8888 port is assigned and expossed to run Jupyter-Notebook.

## For Kubernetes

Follow the commands:

Start the minikube for virtualbox driver
```shell
$ minikube start --vm-driver=virtualbox

$ kubectl config use-context minikube

$ kubectl cluster-info
```

Save docker image from your docker repository to kubernetes local repository:
```shell
$ docker save pranshujain/pyspark-notebook:<version> | pv | (eval $(minikube docker-env) && docker load)
```

Use the kubectl run command to create a Deployment that manages a Pod. The Pod runs a Container based on your **pranshujain/pyspark-notebook:<version>** Docker image. Set the **--image-pull-policy** flag to **Never** to always use the local image, rather than pulling it from your Docker registry
```bash
$ kubectl run pyspark-demo --image=pranshujain/pyspark-notebook:<version> --port=8888 --image-pull-policy=Never

$ kubectl get deployments

```

From your development machine, you can expose the Pod to the public internet using the kubectl expose command:
```bash
$ kubectl expose deployment pyspark-demo --type=LoadBalancer
```
The --type=LoadBalancer flag indicates that you want to expose your Service outside of the cluster. On cloud providers that support load balancers, an external IP address would be provisioned to access the Service. On Minikube, the LoadBalancer type makes the Service accessible through the minikube service command.

```bash
$ kubectl get services

$ minikube service pyspark-demo
```
This will open Jupyter-Notebook in the default web browser.

Here you can code and run Pyspark programs.

To access pod logs:
```shell
$ kubectl get pods

$ kubectl logs <POD-NAME>
```

### Clean up

Now you can clean up the resources you created in your cluster:
```bash
$ kubectl delete service pyspark-demo
$ kubectl delete deployment pyspark-demo
```
Optionally, force removal of the Docker images created:
```bash
$ docker rmi pranshujain/pyspark-notebook:<version> -f
```
Optionally, stop the Minikube VM:
```bash
$ minikube stop
$ eval $(minikube docker-env -u)
```
Optionally, delete the Minikube VM:
```bash
$ minikube delete
```
