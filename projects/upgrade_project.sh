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

for project in *; do
	if [ -d $project ]; then
		cd $project
		$PROJECTTOOL project save format=versioned source=./$project.yyp RESOURCETYPESPATH=$BASE/resourceslist.json PREFABSFOLDER=$BASE/Prefabs
		rm $project.resource_order
		cd ..
	fi
done

cd $BASE
rm resourceslist.json
rm -rf Prefabs
