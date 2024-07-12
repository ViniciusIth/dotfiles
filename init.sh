#!/bin/bash

# Determine the directory of the current script (dotfiles directory)
DOTFILES_DIR=$(cd "$(dirname "$0")"; pwd)

echo "Dotfiles directory: $DOTFILES_DIR"

# Function to create a symbolic link
create_symlink() {
    local SRC=$1
    local DEST=$2

    # # Backup existing file or directory if it exists
    # if [ -e "$DEST" ] || [ -L "$DEST" ]; then
    #     echo "Backing up existing $DEST to $DEST.bak"
    #     cp "$DEST" "$DEST.bak"
    # fi

    if [ -e "$DEST" ] || [ -L "$DEST" ]; then
        echo "$DEST already exist, skipping"
        return
    fi

    ln -s "$SRC" "$DEST"
    echo "Created symlink: $SRC -> $DEST"
}

# Iterate over all files and directories in the dotfiles directory
for FILE in "$DOTFILES_DIR"/.??* "$DOTFILES_DIR"/*; do
    # Skip the dotfiles directory itself
    if [ "$FILE" == "$DOTFILES_DIR" ]; then
        continue
    fi

    # Get the base name of the file or directory
    BASENAME=$(basename "$FILE")

    # Skip init.sh and README.md files
    if [ "$BASENAME" == "install.sh" ] || [ "$BASENAME" == "init.sh" ] || [ "$BASENAME" == "README.md" ] || [ "$BASENAME" == ".git" ]; then
        echo "Skipping init.sh, README.md, and .git"
        continue
    fi

    # Determine the destination path
    if [ "$BASENAME" == ".config" ]; then
        echo "Found .config directory"
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

echo "Done"
