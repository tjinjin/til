# 最新のAMIを取得する
aws ec2 describe-images \
  --filters "Name=platform,Values=windows" \
  --owners amazon  | \
  jq ".Images[] | select(.Name | contains(\"Windows_Server-2012\") \
        and contains(\"-64Bit-Base-\") \
        and contains(\"Japanese\")) | \
        {\"ImageId\":.ImageId, \"Name\":.Name, \"Description\":.Description}"
