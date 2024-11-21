#!/bin/bash

git clone --depth=1 https://github.com/geftactics/new-mac-setup.git /tmp/new-mac-setup
pushd /tmp/new-mac-setup
./setup.sh
popd
rm -rf /tmp/new-mac-setup
