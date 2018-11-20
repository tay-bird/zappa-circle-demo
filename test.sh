set +e
STATUS=$(pipenv run zappa status staging -j 2>&1)
set -e
if [[ $(echo $STATUS | jq . 2>/dev/null) ]];
then pipenv run zappa update staging;
elif [[ "$STATUS" == *"have you deployed yet?" ]];
then echo "DEPLOY";
# then pipenv run zappa deploy staging;
else echo "$STATUS\nUnknown error!" && exit 1
fi
