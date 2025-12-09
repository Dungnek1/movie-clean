#!/bin/bash

# Script to fix better_player namespace issue
# Run this after 'flutter pub get' if the namespace error occurs

BETTER_PLAYER_BUILD_GRADLE="$HOME/.pub-cache/hosted/pub.dev/better_player-0.0.84/android/build.gradle"

if [ -f "$BETTER_PLAYER_BUILD_GRADLE" ]; then
    # Check if namespace already exists
    if ! grep -q "namespace 'com.jhomlala.better_player'" "$BETTER_PLAYER_BUILD_GRADLE"; then
        # Add namespace after 'android {' line
        sed -i "/^android {/a\    namespace 'com.jhomlala.better_player'" "$BETTER_PLAYER_BUILD_GRADLE"
        echo "✅ Added namespace to better_player build.gradle"
    else
        echo "✅ Namespace already exists in better_player build.gradle"
    fi
else
    echo "❌ better_player build.gradle not found at: $BETTER_PLAYER_BUILD_GRADLE"
fi

