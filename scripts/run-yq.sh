#!/bin/bash

# Display Help
Help()
{
    echo "Provide at least one argument"
    echo "Script options:"
    echo
    echo "Syntax: ./run.sh <option> <file1> <file2>"
    echo "options:"
    echo " merge - Merge the files"
    echo " unique - Extract the Unique keys along with their values"
    echo " common - Extract the Common (key, value) pairs"
    echo " sort - Sort the files by key"
    echo
}

# Function to merge the files
MergeFiles()
{   
    echo "Merging files..."
    yq -n "load("$1") * load("$2")"
}

# Function to extract unique keys along with their values
ExtractUnique()
{
    echo "Extracting unique keys along with their values..."
    yq eval-all 'select(fileIndex == 0) * select(fileIndex == 1)' "$1" "$2"
}

# Function to extract common (key, value) pairs
ExtractCommon()
{
    echo "Extracting common (key, value) pairs..."
    yq eval-all 'select(fileIndex == 0 and . as $file1 | input | $file1 == .)' "$1" "$2"
}

# Function to sort the files by key
SortByKey()
{   yq '.myArray |= sort_by(.numBuckets)' sample.yml
    echo "Sorting the files by key..."
    yq eval-all 'sort_by(keys[]) | .' "$1" "$2"
}

# Check if number of arguments provided is less than 3
if [ "$#" -lt 3 ]; then
    Help
    exit 1
fi

# Extract the command and files from the arguments
command="$1"
file1="$2"
file2="$3"

# Perform the specified task based on the command
case "$command" in
    merge)
        MergeFiles "$file1" "$file2"
        ;;
    unique)
        ExtractUnique "$file1" "$file2"
        ;;
    common)
        ExtractCommon "$file1" "$file2"
        ;;
    sort)
        SortByKey "$file1" "$file2"
        ;;
    *)
        echo "Invalid option: $command"
        Help
        exit 1
        ;;
esac
