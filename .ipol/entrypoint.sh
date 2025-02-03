#!/bin/bash
# entrypoint.sh - wraps the application command and filters out unwanted banner messages.

# Execute the command passed as arguments and filter out lines matching the NVIDIA banner.
# Adjust the grep pattern if needed to avoid filtering legitimate output.

"$@" | grep -vE '^(={5,}|== CUDA ==|CUDA Version|NVIDIA CORPORATION|NVIDIA Deep Learning Container License|WARNING: The NVIDIA Driver)'
