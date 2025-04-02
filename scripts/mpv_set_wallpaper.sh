#!/bin/bash

# Check if the IPC socket exists
if [ ! -S ~/.config/mpv/socket ]; then
    # echo "Error: mpv IPC socket not found. Make sure mpv is running with IPC enabled."
    exit 1
fi

# Get the currently playing video URL from mpv
VIDEO_URL=$(echo '{ "command": ["get_property", "path"] }' | socat - ~/.config/mpv/socket | jq -r '.data')

# Check if a video is playing
if [ -z "$VIDEO_URL" ] || [[ "$VIDEO_URL" == "null" ]]; then
    # echo "No video is currently playing in mpv."
    exit 1
fi

# Extract the video ID from the URL
VIDEO_ID=$(yt-dlp --print "%(id)s" "$VIDEO_URL")

# Construct the high-quality thumbnail URL
THUMBNAIL_URL="https://i.ytimg.com/vi/$VIDEO_ID/maxresdefault.jpg"

# Fallback to hqdefault.jpg if maxresdefault.jpg is unavailable
if curl -s --head "$THUMBNAIL_URL" | grep -q "404 Not Found"; then
    THUMBNAIL_URL="https://i.ytimg.com/vi/$VIDEO_ID/hqdefault.jpg"
fi

# Download the thumbnail to a temporary file
TEMP_FILE=$(mktemp --suffix=.jpg)
curl -s "$THUMBNAIL_URL" -o "$TEMP_FILE"

# Set the downloaded thumbnail as the wallpaper using feh
feh --bg-fill "$TEMP_FILE"

# Clean up the temporary file
rm "$TEMP_FILE"

# echo "Wallpaper set to the high-quality thumbnail of the currently playing video."
