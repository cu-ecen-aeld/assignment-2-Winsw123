#!/bin/sh

# Usage: writer.sh <path/to/file> <string to write>

writefile="$1"
writestr="$2"

# verify arguments
if [ -z "$writefile" ] || [ -z "$writestr" ]; then
    echo "Error: missing parameter(s)."
    echo "Usage: $0 <full-path-to-file> <string>"
    exit 1
fi

# ensure directory exists
dir=$(dirname -- "$writefile")
if [ ! -d "$dir" ]; then
    mkdir -p -- "$dir" || {
        echo "Error: could not create directory $dir"
        exit 1
    }
fi

# write string to file, overwrite existing
printf '%s' "$writestr" > "$writefile" 2>/dev/null || {
    echo "Error: could not write to file $writefile"
    exit 1
}

# verify creation
if [ ! -f "$writefile" ]; then
    echo "Error: $writefile not created"
    exit 1
fi

exit 0
