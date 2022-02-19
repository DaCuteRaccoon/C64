#!/bin/bash

# Nix puts files in content-addressed directories but we need the language server to find the files
CL65=$(which cl65)
COMPILER_DIR=$(nix-store -r $CL65 2>/dev/null)

if [ ! -s /home/runner/include ]; then
	ln -svf ${COMPILER_DIR}/share/cc65/include /home/runner/include
fi
