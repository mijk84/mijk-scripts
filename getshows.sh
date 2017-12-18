#!/bin/bash
scripts=/home/mike/scripts

for x in "103" "48" "57"
do
  magnet=$($scripts/rssfeed $x | grep -A1 "720p" | sed -n 2p)
  latest=$(cat $scripts/$x.latest)

  if [[ "$latest" == "$magnet" ]]
  then
    echo RSS $x up to date.
    transmission-remote --auth $(cat $scripts/auth) --add "$latest"
  else
    echo $magnet > $scripts/$x.latest
    transmission-remote --auth $(cat $scripts/auth) --add "$latest"
  fi
done
