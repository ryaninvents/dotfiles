#!/bin/bash
set -euo pipefail

echo 'Installing pyenv...'
brew install pyenv

echo 'Setting up Python 2.7.18...'
pyenv install 2.7.18
pyenv global 2.7.18

echo 'Python installed.'