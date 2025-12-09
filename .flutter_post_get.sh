#!/bin/bash

# Script to automatically fix better_player namespace after flutter pub get
# This script should be run after 'flutter pub get'

BETTER_PLAYER_BUILD_GRADLE="$HOME/.pub-cache/hosted/pub.dev/better_player-0.0.84/android/build.gradle"

if [ -f "$BETTER_PLAYER_BUILD_GRADLE" ]; then
    # Check if namespace already exists
    if ! grep -q "namespace 'com.jhomlala.better_player'" "$BETTER_PLAYER_BUILD_GRADLE"; then
        # Add namespace after 'android {' line
        sed -i "/^android {/a\    namespace 'com.jhomlala.better_player'" "$BETTER_PLAYER_BUILD_GRADLE"
        echo "✅ Fixed: Added namespace to better_player build.gradle"
    fi
else
    echo "⚠️ better_player build.gradle not found"
fi

