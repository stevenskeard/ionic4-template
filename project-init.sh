#!/bin/bash
# ONLY RUN THIS INSIDE THE VAGRANT VM

#Setup fail early
set -e

# Install required global packages
npm install -g ionic cordova

# Prompt for project name
read -p "Enter project name:" projectName

# Create project
ionic start $projectName

# Change to new project dir
cd $projectName

# Copy gradle template
cp ../build.gradle.template ./build.gradle

# Create gradle settings
echo "rootProject.name='$projectName'" > gradle.settings

# Add .gradle to new project's gitignore
echo ".gradle/" >> .gitignore

# Exit
exit 0
