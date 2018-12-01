export JEKYLL_VERSION=3.8.5
docker run --rm \
  --volume="$PWD:/srv/jekyll" \
  -it -p 4000:4000 jekyll/minimal:$JEKYLL_VERSION \
  jekyll serve
