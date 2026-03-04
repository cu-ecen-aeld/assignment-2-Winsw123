#!/bin/sh

# Usage: finder.sh <directory> <search string>
# Count files under the directory and matching lines containing the search string.

filesdir="$1"
searchstr="$2"

# verify both parameters were provided
if [ -z "$filesdir" ] || [ -z "$searchstr" ]; then
    echo "Error: missing parameter(s)."
    echo "Usage: $0 <directory> <search string>"
    exit 1
fi

# verify filesdir is an existing directory
if [ ! -d "$filesdir" ]; then
    echo "Error: $filesdir does not represent a directory"
    exit 1
fi

# count regular files recursively
numfiles=$(find "$filesdir" -type f | wc -l)

# count matching lines (string search) suppressing grep errors
numlines=$(grep -R -F -- "$searchstr" "$filesdir" 2>/dev/null | wc -l)

echo "The number of files are ${numfiles} and the number of matching lines are ${numlines}"
