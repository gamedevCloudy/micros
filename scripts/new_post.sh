#!/bin/bash

DATE=$(date "+%d-%m-%Y %H:%M")

echo "Enter content: (Ctrl+D to end)"
POST_CONTENT=$(cat)

# Escape special characters in the post content
ESCAPED_CONTENT=$(echo "$POST_CONTENT" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')

POSTS_FILE="../posts/posts.json"
if [ ! -f "$POSTS_FILE" ]; then
    echo "[]" > "$POSTS_FILE"
fi
POSTS=$(cat "$POSTS_FILE")

# Add the new post to the beginning of the array
NEW_POSTS=$(echo "[$DATE,$ESCAPED_CONTENT]$POSTS" | sed 's/\]\[/,/')

# Write the updated posts back to the file
echo "$NEW_POSTS" > "$POSTS_FILE"

# Commit and push changes
git add "$POSTS_FILE"
git commit -m "Add new post: $DATE"
git push origin main