#!/bin/bash
SOURCE_REPOSITORY_REF=$(git status | awk 'NR==1{print $NF}')
SOURCE_REPOSITORY_URL=$(git remote show origin | awk 'NR==2{print $NF}')
if [[ -n "$SOURCE_REPOSITORY_REF" ]]; then
  NAMESPACE=$(oc project --short)
  echo git url is $SOURCE_REPOSITORY_URL
  echo git branch is $SOURCE_REPOSITORY_REF
  oc process -f openshift-template.json  \
    -p MEMORY_LIMIT=256Mi \
    -p NAME=$NAME \
    -p NAMESPACE=$NAMESPACE \
    -p SOURCE_REPOSITORY_URL=$SOURCE_REPOSITORY_URL \
    -p SOURCE_REPOSITORY_REF=$SOURCE_REPOSITORY_REF \
  | oc create -f -	
else
  echo "git status didn't resolve a git branch"
  exit 1
fi
