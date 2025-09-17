#!/bin/bash

# Clone all GitHub repositories for the authenticated user

echo "Fetching and cloning all repositories..."

# Get all repos (including private ones) and clone them
gh repo list silvabyte --limit 1000 --json nameWithOwner --jq '.[].nameWithOwner' | while read -r repo; do
  # Extract the repo name (without owner prefix)
  repo_name=$(echo "$repo" | cut -d'/' -f2)

  if [ -d "$repo_name" ]; then
    echo "Skipping $repo - directory already exists"
  else
    echo "Cloning $repo..."
    gh repo clone "$repo"
  fi
done

echo "Finished cloning repositories!"

