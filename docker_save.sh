#!/bin/bash

# preparing backup directory
backup_dir="$HOME/containers"
mkdir $backup_dir > /dev/null 2>&1

# looking for running containers and store their ids to variable
# to export all created containers, also stopped ones, uncomment 2nd variable
running_containers=$(docker ps -q)
#running_containers=$(docker ps -qa)

if [[ -z "$running_containers" ]]; then
  echo "No running containers detected."
  exit 404
fi

# converting id to name and final output filename
for container_id in $running_containers; do
  container_name=$(docker inspect --format '{{.Name}}' "$container_id" | sed 's|/||')
  
  output_file="$backup_dir/${container_name}.tar"

# committing containers to images and saving them to backup location
  echo "Committing container '$container_name' to image"
  docker commit "$container_id" "${container_name}_image:latest"

  if [[ $? == 0 ]]; then
    echo "Container '$container_name' committed successfully"
    echo "Saving image to $output_file"
    docker save "${container_name}_image:latest" -o "$output_file"

    if [[ $? == 0 ]]; then
      echo "Image for container '$container_name' saved successfully"
    else
      echo "Failed to save image for container '$container_name'"
    fi
  else
    echo "Failed to commit container '$container_name'"
  fi
done
