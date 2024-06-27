#!/bin/bash

# Get the current date and time
DATE=$(date "+%d-%m-%Y %H:%M")


echo "Post title: "
POST_TITLE=$(cat)

# Prompt for the post content
echo "Enter your post content (press Ctrl+D when finished):"
POST_CONTENT=$(cat)

# Escape special characters in the post content
ESCAPED_CONTENT=$(echo "$POST_CONTENT" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')

# Read the existing posts
POSTS_FILE="../posts/posts.json"
if [ ! -f "$POSTS_FILE" ]; then
    echo "[]" > "$POSTS_FILE"
fi
POSTS=$(cat "$POSTS_FILE")

# Remove the opening and closing brackets
POSTS=${POSTS#[}
POSTS=${POSTS%]}

# Add the new post to the beginning of the array
NEW_POSTS="[{\"title\":\"$POST_TITLE\",\"date\":\"$DATE\",\"content\":\"$ESCAPED_CONTENT\"}${POSTS:+,$POSTS}]"

# Write the updated posts back to the file
echo "$NEW_POSTS" > "$POSTS_FILE"

# Commit and push changes
git add "$POSTS_FILE"
git commit -m "Add new post: $DATE"
git push origin main