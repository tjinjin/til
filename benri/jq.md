## Cloudformationのstackから指定するパラメータを抜き出す

```
$ aws cloudformation describe-stacks \
  --stack-name test \
  --profile test | \
  jq '.Stacks[].Parameters[] | select(.ParameterKey=="Unixtime").ParameterValue'
```
