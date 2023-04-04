#!/usr/bin/env bash

# ignored_files=( ".codeclimate.yml" ".dockerignore" ".DS_Store" ".eslintignore" ".eslintrc" ".gitattributes" ".gitignore" ".nvmrc" ".yarnrc" "ambient.d.ts" "babel.config.js" "catalog-info.yaml" "Dockerfile" "Dockerfile-sonar" "google_chrome_stable_version_number.txt" "Jenkinsfile" "JenkinsfileLatestChrome" "Makefile" "package.json" "pom.xml" "postcss.config.js" "README.md" "settings.xml" "sonar-project.properties" "stuart_logo.png" "test-report.xml" "tsconfig.json" "yarn-error.log" "yarn.lock")
apps=$(ls apps)

for app in $apps; do
	if git diff origin/master --name-only | grep --quiet "^apps/$app/.*"; then
		echo "$app has changes"
	else
		echo "$app has NO changes"
	fi
done
