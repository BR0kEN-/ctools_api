#!/usr/bin/env bash

set -e
shopt -s extglob

cd "$(dirname "$0")"

# Inject custom PHP configuration.
phpenv config-add php/php.ini
# Install dependencies.
composer install

export CWD="$(pwd -P)"
# Make our packages observable.
export PATH="$CWD/bin:$PATH"
# Save the old location.
export TRAVIS_BUILD_DIR_OLD="$TRAVIS_BUILD_DIR"
# Override the path to directory with a build.
export TRAVIS_BUILD_DIR="$DRUPAL_TEST_MODULE_LOCATION/$DRUPAL_TEST_MODULE_NAME"

# Ensure the directory exists.
mkdir -p "$TRAVIS_BUILD_DIR"
# Copy the module.
rsync -ra --delete --exclude="$CWD" "$TRAVIS_BUILD_DIR_OLD" "$TRAVIS_BUILD_DIR"

# Discover available coding standards.
phpcs --config-set installed_paths "$(find "$CWD/vendor/" -type f -name "ruleset.xml" -exec dirname {} \; | xargs dirname | uniq | paste -sd "," -)"
a2enmod rewrite actions fastcgi alias
phpenv rehash
