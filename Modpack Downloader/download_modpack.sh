#!/usr/bin/env bash

# https://www.curseforge.com/minecraft/modpacks/deceasedcraft
PROJECT_ID=490660
OUTPUT="./data"

KEY=$(cat ./cf_key)
HEADERS="x-api-key: $KEY"
URL="https://api.curseforge.com/v1/mods/$PROJECT_ID"

mainFileId=$(curl -sH "$HEADERS" $URL | jq ".data.mainFileId")
serverPackFileId=$(curl -sH "$HEADERS" $URL/files/$mainFileId | jq ".data.serverPackFileId")
manifest=$(curl -sH "$HEADERS" $URL/files/$serverPackFileId)
displayName=$(echo $manifest | jq -r ".data.displayName")
fileName=$(echo $manifest | jq -r ".data.fileName")
downloadUrl=$(echo $manifest | jq -r ".data.downloadUrl")

# wget $downloadUrl

unzip -fo $fileName -d $OUTPUT