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
> <IPAddress>:8888

as the 8888 port is assigned and expossed to run Jupyter-Notebook.

## For Kubernetes

Follow the commands:

Start the minikube for virtualbox driver
```shell
$ minikube start --vm-driver=virtualbox

$ kubectl config use-context minikube

$ kubectl cluster-info

$ docker save pranshujain/pyspark-notebook:<version> | pv | (eval $(minikube docker-env) && docker load)

$ kubectl run pyspark-demo --image=pranshujain/pyspark-notebook:<version> --port=8888 --image-pull-policy=Never

$ kubectl get deployments

$ kubectl get pods

$ kubectl expose deployment pyspark-demo --type=LoadBalancer

$ kubectl get services

$ minikube service pyspark-demo
```
this will open Jupyter-Notebook in the default web browser.

Here you can code and run Pyspark programs.

To access pod logs:
```shell
$ kubectl logs <POD-NAME>
```

To stop minikube and shutdown kubernetes:
```shell
$ minikube stop
```
