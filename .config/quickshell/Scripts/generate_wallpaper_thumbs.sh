#!/bin/bash
# Assumes magick exists
echo $1 # Base folder Path

rm -r $1/thumbs
mkdir -p $1/thumbs

cd $1 #// move do this working firectory
shopt -s nullglob
for file in *{.png,.jpeg,.jpg,.webp}; do
    echo ./$file
    magick "./$file" -thumbnail '200x200' "$1/thumbs/$file.thumb"
done

for file in *.mp4; do
 
  ffmpeg -y -i "$file" -frames:v 1 "$1/thumbs/temp.png"
  magick "$1/thumbs/temp.png" -thumbnail '200x200' "$1/thumbs/$file.thumb"
  rm "$1/thumbs/temp.png"
done