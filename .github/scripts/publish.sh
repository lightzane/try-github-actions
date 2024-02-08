#!/bin/bash

INCLUDE_TAGS=($(jq -r '.include_tags[]' ./data.json))
EXCLUDE_TAGS=($(jq -r '.exclude_tags[]' ./data.json))

INCLUDE_FLAG=
EXCLUDE_FLAG=

if [ ${#INCLUDE_TAGS[@]} -ge 1 ]; then
    for TAG in ${INCLUDE_TAGS[@]}
    do
        INCLUDE_FLAG="${INCLUDE_FLAG} --include-tag ${TAG}"
    done
else
    INCLUDE_FLAG=--no-include-tags
fi

if [ ${#EXCLUDE_TAGS[@]} -ge 1 ]; then
    for TAG in ${EXCLUDE_TAGS[@]}
    do
        EXCLUDE_FLAG="${EXCLUDE_FLAG} --exclude-tag ${TAG}"
    done
else
    EXCLUDE_FLAG=--no-exclude-tags
fi

SOURCE_VARIANT=

case $GITHUB_BASE_REF in
    feature/dev) SOURCE_VARIANT="devers" ;;
    feature/test) SOURCE_VARIANT="testers" ;;

    *)
        echo "No source variant for: $GITHUB_BASE_REF"
        exit 1
        ;;
esac

# if [ -z "$SOURCE_VARIANT" ]; then
#     echo "No source variant for: $GITHUB_BASE_REF"
#     exit 1
# fi

echo "rover contract publish my-graph@$CONTRACT_NAME --source-variant $SOURCE_VARIANT $INCLUDE_FLAG $EXCLUDE_FLAG"