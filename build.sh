#!/bin/bash
docker-compose up --build
docker-compose down -v
docker rmi camellia-r-oss:0.0.1 2>/dev/null


# docker build \
# --build-arg ADMIN_USERNNAME_1=weblogic \
# --build-arg ADMIN_PASSWORD_1=weblogic1 \
# --build-arg ADMIN_NAME_1=admin \
# --build-arg ...
# --build-arg ... \
# -t test/foo .