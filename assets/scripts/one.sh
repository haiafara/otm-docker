#!/bin/bash


cd /mnt/data

if [ ! -d "/mnt/data/srtm" ]; then
  echo "Please put some HGT ZIP files into the directory /mnt/data/srtm."
  exit
fi

cd srtm
for zipfile in original/*.zip; do
  mkdir -p unpacked
  unzip -j -o "$zipfile" -d unpacked
  pushd unpacked
  for hgtfile in *.hgt; do
    gdal_fillnodata.py $hgtfile $hgtfile.tif
  done
  gdal_merge.py -n 32767 -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 -o ../raw.tif *.hgt.tif
  popd
  rm -f warp-60.tif
  gdalwarp -co BIGTIFF=YES -co TILED=YES -co COMPRESS=LZW -co PREDICTOR=2 -t_srs "+proj=merc +ellps=sphere +R=6378137 +a=6378137 +units=m" -r bilinear -tr 60 60 raw.tif warp-60.tif
  phyghtmap -o contour --max-nodes-per-tile=0 -s 10 -0 --pbf warp-60.tif
  rm -fr unpacked
done

