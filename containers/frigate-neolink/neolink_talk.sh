#!/bin/bash
set -euo pipefail

CAMERA_NAME="${1:?Usage: neolink_talk.sh <camera-name>}"
CONFIG="${NEOLINK_CONFIG:-/config/neolink/neolink.toml}"

trap 'exit 0' SIGTERM SIGINT

ffmpeg \
  -hide_banner \
  -loglevel error \
  -fflags nobuffer \
  -f alaw \
  -ar 8000 \
  -ac 1 \
  -i pipe:0 \
  -f wav \
  pipe:1 \
| neolink talk \
    "${CAMERA_NAME}" \
    -c "${CONFIG}" \
    -m \
    -i "fdsrc fd=0"
