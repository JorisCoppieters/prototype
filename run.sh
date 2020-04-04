#!/bin/bash

set -e # Bail on first error

#npm install -g @angular/cli

echo "#"
echo "# Formatting files"
echo "#"

npm run format

echo "#"
echo "# Running local server"
echo "#"

npm run serve
