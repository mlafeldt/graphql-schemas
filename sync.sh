#!/bin/bash
set -e -o pipefail

: ${GITHUB_TOKEN:?"missing env var"}

sync_schema() {
    local domain="$1"
    shift
    echo "Syncing schema for $domain"
    mkdir -p "$domain"
    get-graphql-schema https://$domain/graphql "$@" > "$domain/schema.graphql"
    get-graphql-schema https://$domain/graphql "$@" --json > "$domain/schema.json"
    git commit -m "Sync schema: $domain" "$domain" || true
}

# Sorted alphabetically
sync_schema api.github.com --header "Authorization=Bearer $GITHUB_TOKEN"
sync_schema api.grafbase.com
sync_schema api.linear.app
