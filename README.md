# ~9MB Linux docker box just for use as ssh bastion

## Usage

Create a `authorized_keys` file with all public keys that can connect to this bastion.

Then run the following command to start the bastion. 

	docker run --name bastion -d --restart=always -v $(pwd)/authorized_keys:/home/dev/.ssh/authorized_keys:ro -p 9022:9022 chentm/bastion

To connect through the bastion

	ssh -A -t -p 9022 dev@bastion.address ssh -t whatever@address.to.connect

## Security

The bastion itself do not have firewalls to limit the source connections. You can use the firewall at the host machine or the security group from AWS to limit the connecitons to port 9022. 

Users can do pretty much nothing with the bastion. Only ssh/sshd commands are available.

## For places where Docker Hub is unreachable eg. China

Run the following commands to build the docker image before running `docker run`

	git clone https://github.com/chentmin/bastion.git
	docker build -t chentm/bastion bastion

It only needs to download ~2MB from Github, although it could be slow to download from China.

## Credits

This bastion is based on [Alpine](!https://hub.docker.com/_/alpine/) Version 3.2.

Security harden script is modified based on [this](!https://github.com/gliderlabs/docker-alpine/issues/56#issuecomment-125777140)