#!/bin/sh
set +x

newarn=`head result.json  |grep taskDefinitionArn | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g'`;

sed -i -e "s/arn/$(echo $newarn)/g" appspec.yaml ;

cat appspec.yaml
