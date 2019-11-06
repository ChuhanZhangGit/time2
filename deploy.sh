#!/bin/bash

export MIX_ENV=prod
export PORT=4797
export NODEBIN=`pwd`/assets/node_modules/.bin
export PATH="$PATH:$NODEBIN"

source ./prod-env.sh

echo "Building..."

# Build Elixir Code
mix deps.get
mix compile

# Build Assets
mkdir -p priv/static
(cd assets && npm install)
(cd assets && webpack --mode production)
echo "phx.digest"
mix phx.digest

# Migrate DB
echo "ecto migrate"
mix ecto.migrate

# Generate the release
echo "mix release"
mix release


#echo "Stopping old copy of app, if any..."
#_build/prod/rel/draw/bin/practice stop || true

echo "Starting app..."

_build/prod/rel/time2/bin/time2 start
