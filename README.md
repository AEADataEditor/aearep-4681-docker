# Docker image basic Julia image

## Purpose

Many Julia replication packages have dependencies, which sometimes include the specific version of Julia (in particular versions prior to 1.0).
This Docker image is meant to isolate and stabilize that environment, and should be portable across
multiple operating system, as long as [Docker](https://docker.com) is available.

## Build

### Adjust the needed packages

See the [0setup.jl](0setup.jl) file, and update accordingly.

> WARNING: not all packages might build, depending on whether the Julia base image has the relevant libraries. You might want to change Julia base image, or switch to another image from [rocker](https://hub.docker.com/u/julia).

### Setup info

Set the `TAG` and `IMAGEID` accordingly.

```
TAG=v$(date +%F)
MYIMG=aer-9999-8888
MYHUBID=aeadataeditor
```

### Build the image

```shell
docker build  . -t $MYIMG:$TAG
```

or if using the newer build system

```shell
DOCKER_BUILDKIT=1 docker build . -t $MYIMG:$TAG
```

## Publish the image

The resulting docker image can be uploaded to [Docker Hub](https://hub.docker.com/), if desired.

```shell
docker push $MYHUBID/${MYIMG}:$TAG
```

## Using the image

If using a pre-built image on [Docker Hub](https://hub.docker.com/repository/docker/aeadataeditor/) or the one you just created:

```shell
docker run -it --rm $MYHUBID/${MYIMG}:$TAG
```

Somewhat more sophisticated, if you are in a project directory (for instance, the replication package you just downloaded), you can access it directly within the image as follows:

```
cd /path/to/project
docker run -it --rm -v $(pwd)/subdir:/code -w /code $MYHUBID/${MYIMG}:$TAG
```

You can now start to run code interactively, for testing.

To run code directly, use

```shell
docker run -it -v $(pwd):/code \
     -w /code \
     $MYHUBID/${MYIMG}:$TAG julia mainmulti.jl
```
