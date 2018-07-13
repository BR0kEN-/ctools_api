#!/usr/bin/env bash

set -e
shopt -s extglob

# Inject custom PHP configuration.
phpenv config-add php/php.ini
# Install dependencies.
composer install
# Update the PATH before the "TRAVIS_BUILD_DIR" changed.
export PATH="$TRAVIS_BUILD_DIR/tests/travis/bin:$PATH"
# Override the path to directory with a build.
export TRAVIS_BUILD_DIR="drupal/sites/all/modules/contrib/$DRUPAL_TESTING_MODULE"
# Ensure the directory exists.
mkdir -p "$TRAVIS_BUILD_DIR"
# Copy the module.
rsync -ra --delete ./ "$TRAVIS_BUILD_DIR" --exclude=tests/travis
# Discover available coding standards.
phpcs --config-set installed_paths "$(find vendor/ -type f -name "ruleset.xml" -exec dirname {} \; | xargs dirname | uniq | paste -sd "," -)"
a2enmod rewrite actions fastcgi alias
phpenv rehash
