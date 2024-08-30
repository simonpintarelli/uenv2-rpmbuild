# USAGE

```
podman build -f docker/Dockerfile
podman run --privileged -v $(pwd):/work:rw -w /work -it uenv2-rpmbuild:latest sh -c 'CXX=g++-12 CC=gcc-12 ./build.sh'
```

The binary rpm is copied at the end to the current working directory.
