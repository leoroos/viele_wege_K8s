#!/bin/bash -eu

echo "Setting Accountnumber to $AWS_ACCOUNT"

set -x
find . -iname '*.yaml' | xargs sed -i.bckup "s/AWS_ACCOUNT_NUMBER/$AWS_ACCOUNT/g"
find . -iname '*.bckup' | xargs rm
