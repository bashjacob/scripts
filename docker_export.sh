#!/bin/bash

# preparing backup directory
backup_dir="$HOME/containers"
mkdir $backup_dir

# looking for running containers and store their ids to variable
# to export all created containers, also stopped one,s uncomment 2nd variable
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

# exporting containers to backup location
  echo "Exporting container '$container_name' to $output_file"
  docker export "$container_id" -o "$output_file"

  if [[ $? == 0 ]]; then
    echo "Container '$container_name' exported successfully"
  else
    echo "Failed to export container '$container_name'"
  fi
done
