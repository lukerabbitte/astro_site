#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 <input_file> <start_line> [end_line]"
    exit 1
fi

input_file="$1"
start_line="$2"
end_line="$3"

if [ -z "$end_line" ]; then
    end_line="$(wc -l < "$input_file")"
fi

if [ "$start_line" -gt "$end_line" ]; then
    echo "Start line must be less than or equal to end line."
    exit 1
fi

# Loop through the lines of the file and append two spaces to each line
while read -r line; do
    ((line_number++))
    if [ "$line_number" -ge "$start_line" ] && [ "$line_number" -le "$end_line" ]; then
        echo "$line  "  # Add two spaces at the end of the line
    else
        echo "$line"  # Output the line as is
    fi
done < "$input_file" > temp_file

# Replace the original file with the modified content
mv temp_file "$input_file"

echo "Added two spaces to the end of each line from line $start_line to line $end_line in $input_file."
