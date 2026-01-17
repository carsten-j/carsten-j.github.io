#!/bin/bash

# Build and serve Jekyll site using Docker with github-pages gem
# This ensures local environment matches GitHub Pages production

# Create _site directory if it doesn't exist
mkdir -p _site

docker run --rm \
  --volume="$PWD:/srv/jekyll:Z" \
  --env JEKYLL_UID="$(id -u)" \
  --env JEKYLL_GID="$(id -g)" \
  -p 4000:4000 \
  jekyll/jekyll:latest \
  bash -c "bundle install && bundle exec jekyll serve --host 0.0.0.0 --drafts"
