# Docker image basic Julia image

## Purpose

Many Julia replication packages have dependencies, which sometimes include the specific version of Julia (in particular versions prior to 1.0).
This Docker image is meant to isolate and stabilize that environment, and should be portable across
multiple operating system, as long as [Docker](https://docker.com) is available. It's very simple, and does NOT use the Project capabilities of Julia.

This particular build incorporates Gurobi, so that Julia can run it. You will need a Gurobi license to use it.

## Build

### Adjust the needed packages

See the [0setup.jl](0setup.jl) file, and update accordingly.

> WARNING: not all packages might build, depending on whether the Julia base image has the relevant libraries. You might want to change Julia base image, or switch to another image from [Docker](https://hub.docker.com/u/julia).

### Setup info

Set a few parameters. In this deposit, they are read from [`.myconfig.sh`](.myconfig.sh).

### Build the image

```shell
docker build  . -t $dockerrepo
```

or if using the newer build system

```shell
DOCKER_BUILDKIT=1 docker build . -t $dockerrepo
```

The convenience script [build.sh](build.sh) does this for you.

## Publish the image

The resulting docker image can be uploaded to [Docker Hub](https://hub.docker.com/), if desired.

```shell
docker push $dockerrepo
```

## Using the image

The image here requires the Gurobi license. We configured it to use a physical file (`gurobi.lic`), but you can also use an environment variable.


```bash
docker run -it  \
   -v $WORKSPACE:/project \
   -v $(pwd)/gurobi.lic:/opt/gurobi/gurobi.lic \
   -w /project \
   --entrypoint /bin/bash \
   --rm  \
   $dockerrepo julia Main.jl
```

The convenience script [run_docker.sh](run_docker.sh) does this for you.