#!/bin/bash
which goss

if [ $? -ne 0 ]; then
	echo "Please install goss from https://goss.rocks/install"
	echo "For a quick auto install run the following"
	echo "curl -fsSL https://goss.rocks/install | sh"
	exit $?
fi

docker build --tag steamcache-generic-testing .
case $1 in
  junit)
    shift;
    mkdir -p ./reports/goss
    export GOSS_OPTS="$GOSS_OPTS --format junit"
	dgoss run $@ steamcache-generic-testing > reports/goss-report.xml
    sed -i '0,/^</d' reports/goss-report.xml
    sed -i '1i<?xml version="1.0" encoding="UTF-8"?>' reports/goss-report.xml
    ;;
  *)
	dgoss run $@ steamcache-generic-testing
    ;;
esac
docker rmi steamcache-generic-testing
