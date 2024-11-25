#!/bin/bash
set -ex

if [ -z $PROJECTTOOL ]; then
	PROJECTTOOL=/e/Source/ProjectTool/Source/bin/Debug/net8.0/ProjectTool
fi

if [ -z $PROJECTTOOL ]; then
	echo "Environment variable CORERESOURCES_DLL is not set skipping convertion!"
	exit 0
fi

BASE=`pwd`
mkdir Prefabs

$PROJECTTOOL SHOWVERSIONEDTYPES DESTINATION=resourceslist.json SOURCE="$CORERESOURCES_DLL"

# Iterate over each item in the current directory
for project in *; do
    # Check if the item is a directory
    if [ -d "$project" ]; then
        echo "Processing project: $project"

        # Check if the required .yyp file exists
        if [ -f "$project/$project.yyp" ]; then
            # Navigate into the project directory using pushd
            pushd "$project" > /dev/null

            # Execute the project save command
            "$PROJECTTOOL" project save format=versioned source="./$project.yyp" RESOURCETYPESPATH="$BASE/resourceslist.json" PREFABSFOLDER="$BASE/Prefabs"

            # Remove the resource_order file if it exists
            if [ -f "$project.resource_order" ]; then
                rm "$project.resource_order"
                echo "Removed $project.resource_order"
            else
                echo "No resource_order file to remove in $project"
            fi

            # Return to the previous directory using popd
            popd > /dev/null

            echo "Successfully processed project: $project"
        else
            echo "Warning: File '$project.yyp' does not exist in directory '$project'. Skipping."
        fi
    else
        echo "Skipping non-directory item: $project"
    fi
done

cd $BASE
rm resourceslist.json
rm -rf Prefabs
