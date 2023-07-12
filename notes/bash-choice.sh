#!/bin/bash

echo "Please choose an option:"
echo "1. Option 1"
echo "2. Option 2"

read choice

if [ $choice -eq 1 ]
then
    echo "You chose Option 1"
    # execute operations for Option 1
elif [ $choice -eq 2 ]
then
    echo "You chose Option 2"
    # execute operations for Option 2
else
    echo "Invalid choice"
fi
