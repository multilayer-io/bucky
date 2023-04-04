#!/bin/bash          

mkdir -p /content
gcsfuse --implicit-dirs -o allow_other $GCS_BUCKET_NAME /content
echo "Mounted succesfully FUSE bucket $GCS_BUCKET_NAME in /content"
ls /content