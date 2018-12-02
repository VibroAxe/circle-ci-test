#!/bin/bash
which goss

if [ $? -ne 0 ]; then
	echo "Please install goss from https://goss.rocks/install"
	echo "For a quick auto install run the following"
	echo "curl -fsSL https://goss.rocks/install | sh"
	exit $?
fi

docker build --tag steamcache-generic-testing .
dgoss run $@ steamcache-generic-testing
docker rmi steamcache-generic-testing
