#!/bin/sh
set -eu
docker run --rm -it -v $(pwd):/code bats/bats:1.7.0 *.bats
