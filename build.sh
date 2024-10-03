#!/bin/bash
#
# Build all Nginx images locally
#

# Load image mappings and central image name from external file
source ./image_mappings.sh

# Iterate over the defined image mappings
for dir in "${!images[@]}"; do
  # Get the corresponding tag for the directory
  tag=${images[$dir]}
  
  # Read the current version from the version.txt file
  version_file="./$dir/version.txt"
  if [[ -f "$version_file" ]]; then
    version=$(cat "$version_file")
  else
    echo "Error: No version.txt found in $dir."
    exit 1
  fi
  
  # Full image tag including the version, using a hyphen to separate the tag
  full_tag="${tag}-${version}"

  # Build the Docker image with the correct image name and tag
  docker build -t "$IMAGE_NAME:$full_tag" ./$dir
  if [[ $? -ne 0 ]]; then
    echo "Build failed for $dir"
    exit 1
  fi
  
  echo "Built and tagged $IMAGE_NAME:$full_tag"
done

echo "All images built successfully."
