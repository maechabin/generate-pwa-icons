#!/bin/bash

if [ -z "$1" ]; then
  echo '画像を指定してください！'
  exit 1
fi

image_file=$1

icons_dir=icons
if [ ! -e ${icons_dir} ]; then
  mkdir ${icons_dir}
fi

convert -resize 512x512 ${image_file} icons/icon-512x512.png
convert -resize 384x384 ${image_file} icons/icon-384x384.png
convert -resize 192x192 ${image_file} icons/icon-192x192.png
convert -resize 152x152 ${image_file} icons/icon-152x152.png
convert -resize 144x144 ${image_file} icons/icon-144x144.png
convert -resize 128x128 ${image_file} icons/icon-128x128.png
convert -resize 96x96 ${image_file} icons/icon-96x96.png
convert -resize 72x72 ${image_file} icons/icon-72x72.png

list=`find ${icons_dir} -maxdepth 1 -type f -name '*.png'`
for file in ${list[@]}; do
  file_name="${file##*/}"
  file_size=`wc -c ${file} | awk '{print $1}'`

  pngquant --ext .png --force --speed 1 --quality=65-80 ${file}

  optimized_size=`wc -c ${file} | awk '{print $1}'`
  optimized_rate=`echo "scale=2; $optimized_size / $file_size * 100" | bc`

  echo "${file}  ${file_size} Bytes ===> ${optimized_size} Bytes (${optimized_rate})"
done
