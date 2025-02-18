#!/bin/bash
# Create a file

touch "$source_file"
if [ $? -eq 0 ]; then
  echo "File '$source_file' created successfully."
else
  echo "Error: Could not create file '$source_file'."
fi

