# How to build and upload the debian package to our internal repository

### Building Dev Environment
```
docker build --no-cache -t fluent-bit-trusty:v1 .
docker run -it -v ~/Source/auth0/fluent-bit-deb:/debian fluent-bit-trusty:v1 /bin/bash
```

### Building Fluent-Bit From Source
Run the following commands inside the docker container

```
make download_package
cd fluent-bit/build
cmake ..
make
```

## Build:
```
make build VERSION_NUMBER=1.0.1
```

This will output a deb package that can be used to install the files.
