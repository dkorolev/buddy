#!/bin/bash
#
# This, obviously, is the job for a hook or integration. -- D.K.

while true ; do
  git fetch >/dev/null

  LOCAL=$(git rev-parse HEAD)
  REMOTE=$(git rev-parse origin/master)
  BASE=$(git merge-base HEAD origin/master)

  if [ $LOCAL = $REMOTE ] ; then
    echo -n "."
    sleep 5
  elif [ $LOCAL = $BASE ] ; then
    echo
    echo "$ git pull"
    git pull
    echo "$ ./restart.sh"
    ./restart.sh
  elif [ $REMOTE = $BASE ]; then
    echo "Local ahead of origin. Aborting."
    exit 0
  else
    echo "Local and origin diverged. Aborting."
    exit 1
  fi
done
