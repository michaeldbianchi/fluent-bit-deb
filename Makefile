build: build_deb

download_package:
	wget https://github.com/fluent/fluent-bit/archive/v${VERSION_NUMBER}.tar.gz
	tar -xzpf v${VERSION_NUMBER}.tar.gz
	rm v${VERSION_NUMBER}.tar.gz
	mv fluent-bit-${VERSION_NUMBER} fluent-bit

build_deb: check-fpm-installed check-version-variable
	fpm --deb-user fluent-bit --deb-group fluent-bit \
	--before-install src/pre-install.sh --after-install src/post-install.sh \
	--before-remove src/pre-remove.sh --after-remove src/post-remove.sh \
	--prefix /opt --deb-upstart src/fluent-bit.conf --deb-default src/fluent-bit \
	--config-files etc/fluent-bit/fluent-bit.conf \
	--config-files etc/fluent-bit/parsers.conf \
	--url 'https://github.com/fluent/fluent-bit' --version $(VERSION_NUMBER) -n fluent-bit \
	-x '**/.git*' \
	--description 'fluent-bit build $(VERSION_NUMBER) packaged by Auth0' \
	--architecture amd64 \
	--maintainer 'Auth0 PSaaS Team' \
	--license 'Apache 2.0' \
	--vendor 'treasure-data' \
	-t deb -s dir fluent-bit

check-version-variable:
ifndef VERSION_NUMBER
	$(error VERSION_NUMBER is undefined)
endif

check-fpm-installed:
	@command -v fpm >/dev/null 2>&1 || { echo >&2 "fpm required to build DEBs but not installed"; \
	echo >&2 "Install with: \n $ sudo apt-get install ruby-dev gcc && sudo gem install fpm"; \
	echo >&2 "Aborting"; exit 1; }