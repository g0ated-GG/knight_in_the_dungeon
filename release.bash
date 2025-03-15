#!/bin/bash
declare -A releases=(["windows"]="./dist/windows/" ["linux"]="./dist/linux/" ["android"]="./dist/android/" ["web"]="./dist/web/")
declare -A archives=(["windows"]="game.windows_x86_64.zip" ["linux"]="game.linux_x86_64.tar.gz" ["android"]="game.android_arm64_v8a.apk" ["web"]="game.web.zip")
for release in ${!releases[@]}; do
  if [ $release != "android" ]; then
    cp -v ./save.cfg "${releases[$release]}"
    cp -v ./README.txt "${releases[$release]}"
  fi
  cd "${releases[$release]}"
  if [ $release = "linux" ]; then
    tar -czvf "../${archives[$release]}" .
  elif [ $release = "android" ]; then
    cp "${archives[$release]}" ../
  else
    zip -rv "../${archives[$release]}" .
  fi
  cd ../..
done
