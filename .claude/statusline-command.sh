#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract model display name
model_name=$(echo "$input" | jq -r '.model.display_name')

# Extract context window information
remaining_pct=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // empty')

# Build the status line
status_line="$model_name"

# Add context information with battery emoji if available
if [ -n "$remaining_pct" ] && [ -n "$used_pct" ] && [ -n "$context_size" ]; then
  # Choose battery emoji based on remaining percentage
  if (($(echo "$remaining_pct < 20" | bc -l))); then
    battery_emoji="🪫" # Low battery
  else
    battery_emoji="🔋" # Normal battery
  fi

  # Calculate remaining tokens
  total_used=$(echo "$total_input + $total_output" | bc)
  remaining_tokens=$(echo "$context_size - $total_used" | bc)

  # Format tokens with k/M prefix and 2 significant figures
  if [ "$remaining_tokens" -ge 1000000 ]; then
    # Millions
    formatted_tokens=$(node -e "console.log(($remaining_tokens / 1e6).toLocaleString('en-US', { maximumSignificantDigits: 2, useGrouping: false }))")
    token_str="${formatted_tokens} Mtok"
  elif [ "$remaining_tokens" -ge 1000 ]; then
    # Thousands
    formatted_tokens=$(node -e "console.log(($remaining_tokens / 1e3).toLocaleString('en-US', { maximumSignificantDigits: 2, useGrouping: false }))")
    token_str="${formatted_tokens} ktok"
  else
    # Raw tokens
    formatted_tokens=$(node -e "console.log(($remaining_tokens).toLocaleString('en-US', { maximumSignificantDigits: 2, useGrouping: false }))")
    token_str="${formatted_tokens} tok"
  fi

  # Add to status line with percentage and token count
  status_line="$status_line | $battery_emoji ${remaining_pct}% ($token_str)"
fi

echo "$status_line"
