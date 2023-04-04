#!/usr/bin/env bash

# ignored_files=( ".codeclimate.yml" ".dockerignore" ".DS_Store" ".eslintignore" ".eslintrc" ".gitattributes" ".gitignore" ".nvmrc" ".yarnrc" "ambient.d.ts" "babel.config.js" "catalog-info.yaml" "Dockerfile" "Dockerfile-sonar" "google_chrome_stable_version_number.txt" "Jenkinsfile" "JenkinsfileLatestChrome" "Makefile" "package.json" "pom.xml" "postcss.config.js" "README.md" "settings.xml" "sonar-project.properties" "stuart_logo.png" "test-report.xml" "tsconfig.json" "yarn-error.log" "yarn.lock")
apps=$(ls apps)
other_dirs=$(ls -d */ | grep --invert-match "^apps")
apps_with_changes=()
apps_with_no_changes=()

# Check for changes in the other directories
for dir in $other_dirs; do
	# If any folder that is not apps is changes we want to build all the apps
	if git diff origin/master --name-only | grep --quiet "^$dir.*"; then
		exit 1
	fi
done

# Check for changes in the apps/* directories
for app in $apps; do
	if git diff origin/master --name-only | grep --quiet "^apps/$app/.*"; then
		apps_with_changes+=("$app")
		echo "${apps_with_changes[*]}" >apps_with_changes.txt
	else
		apps_with_no_changes+=("$app")
		echo "${apps_with_no_changes[*]}" >apps_with_no_changes.txt
	fi
done
