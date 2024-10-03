
IMAGE_NAME="geschke/nginx-swrm"

# Define an associative array that maps directory names to image tags
declare -A images=(
  ["ubuntu-22.04"]="1.18"
  ["ubuntu-24.04"]="1.24"

)
