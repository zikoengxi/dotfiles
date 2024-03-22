#!/usr/bin/env bash

# Python
# =========================================================== #

asdf plugin add python https://github.com/asdf-community/asdf-python.git

# Install python
PYTHON_VERSION='3.10.13'
asdf install python ${PYTHON_VERSION}
asdf global python ${PYTHON_VERSION}

# Upgrade pip to latest
pip install --upgrade pip

# NodeJS
# =========================================================== #

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

# Install nodejs
NODEJS_VERSION='20.11.1'
asdf install nodejs ${NODEJS_VERSION}
asdf global nodejs ${NODEJS_VERSION}

# Upgrade npm to latest
npm install -g npm

# Golang
# =========================================================== #

asdf plugin add golang https://github.com/asdf-community/asdf-golang.git

# Install golang
GOLANG_VERSION='1.22.1'
asdf install golang ${GOLANG_VERSION}
asdf global golang ${GOLANG_VERSION}

# fix: Get any new shims
asdf reshim golang
