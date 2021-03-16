#!/usr/local/bin/bash

CACHE="cache"

if [ ! -d "$CACHE" ]
then 
  echo "Cache dir not found $CACHE"
  exit 1
fi

TAG="$1"
URL="$2"
NOTIFY="$3"
DT=$(date +%Y-%m-%d-%H:%M:%S)

TMP_FILE="$CACHE/temp.page"
cat /dev/null > "$TMP_FILE"

CACHE_FILE="$CACHE/${TAG}.page"

curl --silent --output "$TMP_FILE" "$URL" 

if [ ! -f "$CACHE_FILE" ]
then
  echo "${DT} First time for $TAG - no changes"
  mv "$TMP_FILE" "$CACHE_FILE"
  exit 0
fi

diff --ignore-case --ignore-space-change --ignore-all-space \
  --ignore-blank-lines --text --brief \
  "$CACHE_FILE" "$TMP_FILE" >/dev/null
if [ $? -eq 0 ]
then
  echo "${DT} No changes $TAG"
else
  echo "${DT} Changes found $TAG"
  mv "$TMP_FILE" "$CACHE_FILE"
  if [ ! -z "$NOTIFY" ]
  then
    echo "${DT} Notifying $NOTIFY"
    curl --silent "$NOTIFY"
  fi
fi

exit 0