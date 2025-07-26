#!/bin/bash
declare -A releases=(["windows"]="./dist/windows/" ["linux"]="./dist/linux/" ["android"]="./dist/android/" ["web"]="./dist/web/" ["mac"]="./dist/mac/")
declare -A archives=(["windows"]="windows.x86_64.zip" ["linux"]="linux.x86_64.tar.gz" ["android"]="android.arm64_v8a.x86_64.apk" ["web"]="web.zip" ["mac"]="mac.x86_64.arm64.zip")
for release in ${!releases[@]}; do
  if [ $release != "android" ]; then
    cp -v ./save.cfg "${releases[$release]}"
    cp -v ./README.txt "${releases[$release]}"
  fi
  cd "${releases[$release]}"
  if [ $release = "linux" ]; then
    tar -czvf "../${archives[$release]}" .
  elif [ "$release" == "mac" ]; then
    cp "${archives[$release]}" ../
  elif [ "$release" == "android" ]; then
    cp "${archives[$release]}" ../
    cp "${archives[$release]}.idsig" ../
  else
    zip -rv "../${archives[$release]}" .
  fi
  cd ../..
done
