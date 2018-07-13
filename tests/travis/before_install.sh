#!/usr/bin/env bash

set -e
shopt -s extglob

# Inject custom PHP configuration.
phpenv config-add php/php.ini
# Install dependencies.
composer install

# Save the old location.
export TRAVIS_BUILD_DIR_OLD="$TRAVIS_BUILD_DIR"
# Update the PATH before the "TRAVIS_BUILD_DIR" gets changed.
export PATH="$(cd "$(dirname "$0")" && pwd -P)/bin:$PATH"
# Override the path to directory with a build.
export TRAVIS_BUILD_DIR="$DRUPAL_TEST_MODULE_LOCATION/$DRUPAL_TEST_MODULE_NAME"

# Ensure the directory exists.
mkdir -p "$TRAVIS_BUILD_DIR"
# Copy the module.
rsync -ra --delete --exclude="$(dirname "$0")" "$TRAVIS_BUILD_DIR_OLD" "$TRAVIS_BUILD_DIR"

# Discover available coding standards.
phpcs --config-set installed_paths "$(find vendor/ -type f -name "ruleset.xml" -exec dirname {} \; | xargs dirname | uniq | paste -sd "," -)"
a2enmod rewrite actions fastcgi alias
phpenv rehash
