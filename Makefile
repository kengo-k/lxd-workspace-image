launch:
	lxc network set lxdbr0 ipv4.address 192.168.123.1/24
	lxc launch ubuntu:22.04 workspace \
		-c security.nesting=true \
		-c security.privileged=true \
		-c user.user-data="$$(cat cloud-init.yaml)"
	lxc config device add workspace ssh disk source=$$HOME/.ssh path=/home/workspace-user/.ssh
	lxc config device add workspace zshrc disk source=$$PWD/.zshrc path=/home/workspace-user/.zshrc

install:
	lxc config device add workspace init disk source=$$PWD/init path=/home/workspace-user/init

clean:
	lxc stop workspace
	lxc delete workspace

sh:
	lxc exec workspace su - workspace-user
