#!/bin/bash
set -ex

if [ -z $PROJECTTOOL ]; then
	PROJECTTOOL=/e/Source/ProjectTool/Source/bin/Debug/net8.0/ProjectTool
fi
BASE=`pwd`

$PROJECTTOOL SHOWVERSIONEDTYPES DESTINATION=resourceslist.json

for project in *; do
	if [ -d $project ]; then
		cd $project
		$PROJECTTOOL project save format=versioned source=./$project.yyp forcevers0=true RESOURCETYPESPATH=$BASE/resourceslist.json PREFABSFOLDER=.
		rm $project.resource_order
		cd ..
	fi
done

cd $BASE
rm resourceslist.json
