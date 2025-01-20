#!/bin/bash

# Loop through each folder in the 1BCD directory
for prep_folder in *_RAPA_PREP_*_MD; do
  # Extract the folder name number (e.g., 1, 2, 3, ...)
  basename="${prep_folder%%_RAPA_PREP*}"
  folder_number=$(echo "$prep_folder" | sed -E 's/.*_([0-9]+)_MD$/\1/')

  # Loop through the files inside the current folder
  for file in "$prep_folder"/*; do
    # Skip if no files are found
    [ -e "$file" ] || continue

    # Get the file extension
    ext="${file##*.}"
    
    # Extract the new file name based on the folder name and file extension
    if [[ "$ext" == "pdb" || "$ext" == "prmtop" || "$ext" == "rst7" ]]; then
      new_name="${basename}_RAPA_PREP_${folder_number}_complex.${ext}"
      mv "$file" "$prep_folder/$new_name"
    fi
  done
done
