#!/bin/bash
#
# This, obviously, is the job for supervisord.

if [ "$1" != "kill" ] ; then
  make -B buddy || exit 1
fi

curl localhost:3000/shutdown
pkill buddy

if [ "$1" != "kill" ] ; then
  sleep 0.05
  ./buddy &
  echo "Started."
else
  echo "Killed."
fi
