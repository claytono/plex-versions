#!/bin/bash -eu

set -o pipefail

TRAVIS_COMMIT_MESSAGE=${TRAVIS_COMMIT_MESSAGE:-none}
TRAVIS_EVENT_TYPE=${TRAVIS_EVENT_TYPE:-none}
TRAVIS=${TRAVIS:-false}

if [[ $TRAVIS_EVENT_TYPE != 'cron' && $TRAVIS_EVENT_TYPE != 'api' ]]; then
    echo "This isn't a manual build or cron job, so not checking if we should commit"
    exit 0
fi

echo "This is either a manual poll or a cron job, checking if we should commit"
if git diff --quiet --exit-code raw/*-latest.json; then
    echo "No changes, skipping commit"
    exit 0
fi

echo "Committing changes..."

if [[ $TRAVIS != "false" ]]; then
    echo "Running under travis, fixing up git config"
    git remote rm origin
    git remote add origin "https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}/"
    git config user.name "Travis-CI"
    git config user.email "noreply@travis-ci.org"
fi

git add raw pretty versions
git commit -m "Travis #${TRAVIS_BUILD_NUMBER}"
git push origin HEAD:master
