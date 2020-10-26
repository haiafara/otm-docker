#!/bin/bash

cd /mnt/data/srtm
phyghtmap -o contour --max-nodes-per-tile=0 -j 32 -s 10 -0 --pbf -a -10:32:46:70 --source=view3 --viewfinder-mask=3

