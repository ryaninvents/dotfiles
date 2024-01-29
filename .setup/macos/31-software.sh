#!/bin/sh

brewfile_dir="$(dirname "$0")/Brewfiles"
essentials_path="$brewfile_dir/essentials.Brewfile"
advanced_dev_path="$brewfile_dir/advanced-dev.Brewfile"

if [[ $CUSTOM_SOFTWARE =~ " Essentials " ]]; then
    echo 'Installing essential software...'
    brew bundle --file="$essentials_path"
    
    nvm install v20.9.0
    nvm alias default v20.9.0
    
    corepack enable
fi
if [[ $CUSTOM_SOFTWARE =~ " AdvancedDev " ]]; then
    echo 'Installing advanced dev software...'
    brew bundle --file="$advanced_dev_path"

    nvm install v20.9.0
    nvm alias default v20.9.0
    
    corepack enable
fi
echo 'Software installed.'