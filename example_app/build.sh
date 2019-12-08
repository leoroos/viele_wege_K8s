#!/bin/bash -ex
whatshouldido=$1
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ECR_REGISTRY=${AWS_ACCOUNT}.dkr.ecr.eu-central-1.amazonaws.com/lroos-helloworld
VERSION=latest

cd $SCRIPT_DIR

docker build . -t "helloworld:$VERSION"

if [ "$whatshouldido" = 'run' ]; then
    docker run -p 8080:8080 --rm --name helloworld "helloworld:$VERSION"
fi

if [ "$whatshouldido" = 'ecr' ]; then
    docker tag helloworld:$VERSION "$ECR_REGISTRY:$VERSION"
    docker push "$ECR_REGISTRY:$VERSION"
    # might have to run
    # $(aws ecr get-login --no-include-email)
fi
