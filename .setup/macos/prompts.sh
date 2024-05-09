#!/bin/bash
set -euo pipefail

special_options=("Essentials" "AdvancedDev")

# Function to show menu and get user selection
get_user_selection() {
    echo "Please select values (separated by spaces):"
    for i in "${!special_options[@]}"; do
        echo "$((i + 1))) ${special_options[i]}"
    done

    read -p "Enter your choices (e.g., 1 3 5): " choices

    selected_values=()
    for choice in $choices; do
        selected_values+=("${special_options[$((choice - 1))]}")
    done
}

get_user_selection
echo "You selected: ${selected_values[*]}"

export CUSTOM_SOFTWARE=" ${selected_values[*]} "