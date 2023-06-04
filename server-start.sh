#!/usr/bin/env bash

set -eu -o pipefail

# Set default values
port=2890
workers=3
log_level=INFO

# Parse command line arguments
while getopts ":p:w:-:" opt; do
  case $opt in
    p) port="$OPTARG"
    ;;
    w) workers="$OPTARG"
    ;;
    -) case "${OPTARG}" in
            log-level=*) log_level="${OPTARG#*=}"
            ;;
            *) echo "Invalid option --${OPTARG}" >&2
               exit 1
            ;;
       esac
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

proxy \
  --enable-reverse-proxy \
  --plugins reverse_proxy.ReverseProxyPlugin \
  --hostname 0.0.0.0 \
  --port $port \
  --num-workers=$workers \
  --threaded \
  --log-level=$log_level
