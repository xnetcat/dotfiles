#!/bin/bash

for d in */ ; do
  echo "[INFO] Building in $d"
  cd $d
  sudo make clean install
  if [ $? -ne 0 ]; then
    echo "[ERROR] An error occured..."
    exit 1
  fi
  cd ..
  echo "[INFO] Done..."
done

echo "[INFO] All builds done, you might want to check whether any errors has occures"