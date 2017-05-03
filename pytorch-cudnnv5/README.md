# PyTorch docker file

First follow the docker install instruction from [pytorch](https://github.com/pytorch/pytorch).

Then execute in this directory:

```
$ ./docker_userify.sh
```

This will create a subdirectory with a Dockerfile that includes a user that
matches the host user.

Build it with this command (use our own image name):

```
$ nvidia-docker build -t [my_pytorch_image] .
```

A possible run command could be:

```
$ nvidia-docker run -it \
    -v /home:/home \
    --privileged \
    --net=host \
    --cap-add=ALL \
    [my_pytorch_image]
```
