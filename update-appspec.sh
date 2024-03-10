#!/bin/sh
set +x

newarn=`grep -o '"taskDefinitionArn": "[^"]*' result.json | awk -F': "' '{print $2}'`;

sed -i -e "s|arn|$(echo $newarn)|g" appspec.yaml ;

cat appspec.yaml
