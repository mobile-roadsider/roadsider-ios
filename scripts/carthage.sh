#!/bin/bash
set -eu
: ${SCRIPT_INPUT_FILE_COUNT?"This script requires environment variable SCRIPT_INPUT_FILE_COUNT to be set"}
# This script is to be used as a build phase script for targets which have Carthage framework dependencies
# SYNOPSIS: carthage
# USAGE:
# 1 - Add a run script build phase to your target
# 2 - Call this script in the run script
# 3 - Specify the carthage frameworks required as input files for the run script phase
# NOTE: this script assumes that all input files are in the same directory and the same Cartfile


INPUT_COUNT=${SCRIPT_INPUT_FILE_COUNT}
INPUT_BASE="SCRIPT_INPUT_FILE_"
CARTHAGE_PATH="Carthage/Build/iOS"

if (( INPUT_COUNT > 0 )); then
	echo "$INPUT_COUNT input files provided"
	COUNTER=0
	tmp="${INPUT_BASE}0"
	FILE=${!tmp}
	DIR=$(dirname "${FILE}")
	PROJECT_ROOT=${DIR%/$CARTHAGE_PATH}

	# This parameter collects the names of the frameworks that need to be built
	BUILD_FRAMEWORKS=""
	# Count the number of frameworks that need to be built
	FRAMEWORKS_TO_BUILD_COUNT=0

	# loop through count of input files
	while (( COUNTER < INPUT_COUNT )); do

		# build the file variable name from the count
		tmp="${INPUT_BASE}${COUNTER}"
		FILE=${!tmp}
		# check if file exists
		test -d "$FILE" || {
			filename="${FILE##*/}"
			filename="${filename%.*}"

			# if file does not exist, append the file to the BUILD_FRAMEWORKS parameter and increment the build count
			BUILD_FRAMEWORKS="${BUILD_FRAMEWORKS}${filename} "
			(( FRAMEWORKS_TO_BUILD_COUNT++ ))
			echo "Added file, Building: $BUILD_FRAMEWORKS"
		}

		(( COUNTER++ ))
	done

	## if we have frameworks to build, run carthage build with the BUILD_FRAMEWORKS parameter
	if (( FRAMEWORKS_TO_BUILD_COUNT > 0 )); then
		echo "Running command /usr/local/bin/carthage build ${BUILD_FRAMEWORKS} --platform 'iOS' --project-directory ${PROJECT_ROOT}"
		/usr/local/bin/carthage build ${BUILD_FRAMEWORKS} --platform "iOS" --project-directory "${PROJECT_ROOT}"
	fi
fi
