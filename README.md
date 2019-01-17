# How to build and upload the debian package to our internal repository

## Prerequisites:
### Install [fpm](https://github.com/jordansissel/fpm)
```
brew install gnu-tar
gem install --no-ri --no-rdoc fpm

```

### Install [deb-s3](https://github.com/krobertson/deb-s3)
```
gem install deb-s3
```

### Import gpg key
```
gpg --recv-keys A9DE0468DA53FD14D37A347A9CA4D1BEF63E3D3A --keyserver keyserver.ubuntu.com
```

## Build:
```
make build VERSION_NUMBER=3.3.11
```


## Upload:

### Upload to public apt repository
```
deb-s3 upload --lock --sign F63E3D3A --visibility public --preserve-versions --s3-region us-west-1 --cache-control=no-cache --bucket debs.auth0.com etcd_VERSION_.deb
```

### Upload to private apt repository
```
deb-s3 upload --lock --sign F63E3D3A --visibility private --preserve-versions --s3-region us-west-1 --cache-control=no-cache --bucket apt.auth0.com etcd_VERSION_.deb
```