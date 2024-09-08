#!/bin/bash

# Directories to monitor
MOVIES_DIR="/new-pool/media/movies"
TVSHOWS_DIR="/new-pool/media/tvshows"

# Set the askPass helper script
export SUDO_ASKPASS=/home/rohin/apps/askpass.sh

# Monitor the directories and perform chown when changes happen
inotifywait -m -r -e modify,attrib,close_write,move,create,delete --format '%w' $MOVIES_DIR $TVSHOWS_DIR | while read DIR
do
  if [[ $DIR == "$MOVIES_DIR"* ]]; then
    echo "Change detected in $MOVIES_DIR"
    sudo -A chown -R rohin:rohin "$MOVIES_DIR"
  elif [[ $DIR == "$TVSHOWS_DIR"* ]]; then
    echo "Change detected in $TVSHOWS_DIR"
    sudo -A chown -R rohin:rohin "$TVSHOWS_DIR"
  fi
done
