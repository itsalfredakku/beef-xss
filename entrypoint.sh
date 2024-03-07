#!/bin/bash

# Check if CONFIG_YAML environment variable is set
if [ -n "$CONFIG_YAML" ]; then
    # Write the value of CONFIG_YAML to a file
    echo "$CONFIG_YAML" > config.yaml
fi

# Execute the beef command
exec ./beef
