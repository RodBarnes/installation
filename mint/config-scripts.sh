#!/usr/bin/env bash
#v1.00

DIR=$(dirname $(readlink -f $0))

if [[ "$EUID" = 0 ]]; then
  echo "This must be run as the standard user that will use the device.\nIt will prompt for sudo when it is needed."
  exit
fi

# Copy the scripts, make them executable, then move then to /usr/local/bin
sudo mkdir /tmp/TOOL_SCRIPTS

pushd "$DIR"
sudo cp ../tools/bin/* /tmp/TOOL_SCRIPTS
sudo chown root:root /tmp/TOOL_SCRIPTS/*
sudo chmod +x /tmp/TOOL_SCRIPTS/*

pushd /tmp/TOOL_SCRIPTS
for file in *.sh; do
	sudo mv "$file" "/usr/local/bin/${file%.sh}"
done
popd

sudo cp ../tools/lib/* /tmp/TOOL_SCRIPTS
sudo chown root:root /tmp/TOOL_SCRIPTS/*
sudo mv /tmp/TOOL_SCRIPTS/* /usr/local/lib

sudo rmdir /tmp/TOOL_SCRIPTS

popd
