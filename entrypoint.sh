#!/usr/bin/env bash

# Evaluate environment variables
INPUT_IMAGE=$(echo $(eval "echo $INPUT_IMAGE"))
INPUT_OPTIONS=$(echo $(eval "echo $INPUT_OPTIONS"))

if [ ! -z $INPUT_USERNAME ];
then echo $INPUT_PASSWORD | docker login $INPUT_REGISTRY -u $INPUT_USERNAME --password-stdin
fi

echo "$INPUT_RUN" | sed -e 's/\\n/;/g' > semicolon_delimited_script

echo "$INPUT_RUN" | sed -e 's/\\n/;/g'
echo "$INPUT_IMAGE" | sed -e 's/\\n/;/g'
echo "$INPUT_OPTIONS" | sed -e 's/\\n/;/g'
printenv

exec docker run -v "/var/run/docker.sock":"/var/run/docker.sock" $INPUT_OPTIONS --entrypoint=$INPUT_SHELL $INPUT_IMAGE -c "`cat semicolon_delimited_script`"
