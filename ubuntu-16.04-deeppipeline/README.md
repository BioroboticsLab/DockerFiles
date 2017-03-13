# Docker file for the bb_pipeline

This docker file holds all dependencies to run and develop the bb_pipeline and related projects.

There is a general [Dockerfile](Dockerfile) for all the dependencies. 
And the `./generate_user_dockerfile.sh`  to create a Dockerfile to match the user id of the host user.

## Setup

If the image `deeppipeline/ubuntu-16.04` does not exists you can build it with:

```
$ ./build.sh
```

## Customize

To match the user id of the host system, create your own custom docker file with:

```
$ ./generate_user_dockerfile.sh
```

See `./generate_user_dockerfile.sh --help` for additional options (username, id, password).
The Dockerfile is created in the new directory `$USER-deeppipeline`. You can build it with
`docker build --tag [your image name] .`.
