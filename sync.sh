#!/bin/bash
set -e -o pipefail

: ${GITHUB_TOKEN:?"missing env var"}

echo "Syncing GitHub schema..."
get-graphql-schema https://api.github.com/graphql --header "Authorization=Bearer $GITHUB_TOKEN" > api.github.com/schema.graphql
get-graphql-schema https://api.github.com/graphql --header "Authorization=Bearer $GITHUB_TOKEN" --json > api.github.com/schema.json

echo "Syncing Grafbase schema..."
get-graphql-schema https://api.grafbase.com/graphql > api.grafbase.com/schema.graphql
get-graphql-schema https://api.grafbase.com/graphql --json > api.grafbase.com/schema.json

echo "Syncing Linear schema..."
get-graphql-schema https://api.linear.app/graphql > api.linear.app/schema.graphql
get-graphql-schema https://api.linear.app/graphql --json > api.linear.app/schema.json
