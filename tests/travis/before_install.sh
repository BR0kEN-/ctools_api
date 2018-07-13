#!/usr/bin/env bash

# Go to the directory where this script is located.
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
rsync -ra --delete --exclude="${CWD//$TRAVIS_BUILD_DIR_OLD\//}" "$TRAVIS_BUILD_DIR_OLD" "$TRAVIS_BUILD_DIR"

# Discover available coding standards.
phpcs --config-set installed_paths "$(find "$CWD/vendor/" -type f -name "ruleset.xml" -exec dirname {} \; | xargs dirname | uniq | paste -sd "," -)"
phpenv rehash

sudo a2enmod rewrite actions fastcgi alias
sudo service apache2 restart

echo "$TRAVIS_BUILD_DIR"
ls -la drupal
ls -la drupal/sites
ls -la drupal/sites/all
ls -la drupal/sites/all/modules
ls -la drupal/sites/all/modules/contrib

phpcs "$TRAVIS_BUILD_DIR/" --standard=Drupal
phpcs "$TRAVIS_BUILD_DIR/" --standard=PHPCompatibility --runtime-set testVersion "$TRAVIS_PHP_VERSION"
