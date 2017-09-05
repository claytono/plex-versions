#!/bin/bash -xveu

set -o pipefail

export TZ=UTC
TIMESTAMP=$(date +'%Y%m%dT%H%M%S')
BASEDIR=$(cd "$(dirname "$0")"; pwd)

rm -rf "$BASEDIR/venv"
virtualenv -p python2 venv

venv/bin/pip install -r "$BASEDIR/requirements.txt"

mkdir -p raw
curl -v https://plex.tv/api/downloads/1.json \
    > "$BASEDIR/raw/pms-$TIMESTAMP.json"
cp "$BASEDIR/raw/pms-$TIMESTAMP.json" \
    "$BASEDIR/raw/pms-latest.json"

mkdir -p pretty
jq . < "$BASEDIR/raw/pms-$TIMESTAMP.json" \
    > "$BASEDIR/pretty/pms-$TIMESTAMP.json"
cp "$BASEDIR/pretty/pms-$TIMESTAMP.json" \
    "$BASEDIR/pretty/pms-latest.json"

venv/bin/python support/update-versions.py raw/pms-latest.json
