# USAGE

```
podman build -f docker/Dockerfile
podman run -v $(pwd):/work:rw -w /work -it uenv2-rpmbuild:latest sh -c 'CXX=g++-12 CC=gcc-12 ./build.sh'
```

# Podman config on vCluster
`$HOME/.config/containers/storage.conf`:
```conf
[storage]
  driver = "overlay"
  runroot = "/dev/shm/<username>/runroot"
  graphroot = "/dev/shm/<username>/root"

[storage.options.overlay]
  mount_program = "/usr/bin/fuse-overlayfs-1.13"
```
