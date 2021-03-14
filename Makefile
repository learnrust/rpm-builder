# rustup target add x86_64-unknown-linux-musl
build:
	cargo build --release
build_linux: src/main.rs
	cargo build --release --target x86_64-unknown-linux-musl

package: build_linux build
	target/release/rpm-builder \
		--exec-file "target/x86_64-unknown-linux-musl/release/rpm-builder:/usr/bin/rpm-builder" \
		--config-file "target/rpm-builder.bash:/etc/bash_completion.d/rpm-builder.bash" \
		--version ${VERSION} \
		--release ${RELEASE} \
		--compression gzip \
		--desc    "Description 01"        \
		rpm-builder
install:
	sudo yum localinstall rpm-builder.rpm -y

remove:
	sudo yum remove rpm-builder -y
commit:
	git commit -a -m"lazy comment" && git push
