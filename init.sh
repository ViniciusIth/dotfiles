#!/bin/bash

# Determine the directory of the current script (dotfiles directory)
DOTFILES_DIR=$(cd "$(dirname "$0")"; pwd)

# Function to create a symbolic link
create_symlink() {
    local SRC=$1
    local DEST=$2

    # Backup existing file or directory if it exists
    # if [ -e "$DEST" ] || [ ! -L "$DEST" ]; then
    #     echo "Backing up existing $DEST to $SRC.bak"
    #     mv "$DEST" "$SRC.bak"
    # fi

    # Create the symbolic link
    ln -s "$SRC" "$DEST"
    echo "Created symlink: $SRC -> $DEST"
}

# Iterate over all files and directories in the dotfiles directory
for FILE in "$DOTFILES_DIR"/*; do
    # Get the base name of the file or directory
    BASENAME=$(basename "$FILE")
    
    # Skip init.sh and README.md file
    if [ "$BASENAME" == "init.sh" ] || [ "$BASENAME" == "README.md" ]; then
        continue
    fi

    # Determine the destination path
    if [ "$BASENAME" == ".config" ]; then
        # Special handling for the .config directory
        for CONFIG_DIR in "$DOTFILES_DIR/.config"/*; do
            CONFIG_BASENAME=$(basename "$CONFIG_DIR")
            DEST="$HOME/.config/$CONFIG_BASENAME"
            create_symlink "$CONFIG_DIR" "$DEST"
        done
    else
        DEST="$HOME/$BASENAME"
        create_symlink "$FILE" "$DEST"
    fi
done
