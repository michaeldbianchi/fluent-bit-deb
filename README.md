# How to build and upload the debian package to our internal repository

### Building Dev Environment
Run the following commands from within the repo folder

```
docker build --no-cache -t fluent-bit-trusty:v1 .
docker run -it -v `(pwd)`:/debian fluent-bit-trusty:v1 /bin/bash
```

### Building Fluent-Bit From Source
Run the following commands inside the docker container

```
cd debian
make download_package VERSION_NUMBER=<fluent-bit-version>
cd fluent-bit/build
cmake ..
make
```

## Build:
```
make build VERSION_NUMBER=<fluent-bit-version>
```

This will output a deb package that can be used to install the files.
