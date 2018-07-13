#!/usr/bin/env bash

# Go to the directory where this script is located.
cd "$(dirname "$0")"

echo "Inject custom PHP configuration."
phpenv config-add php/php.ini

echo "Install dependencies."
composer install

echo "Compute facts."
export CWD="$(pwd -P)"
# Make our packages observable.
export PATH="$CWD/bin:$PATH"
# Save the old location.
export TRAVIS_BUILD_DIR_OLD="$TRAVIS_BUILD_DIR"
# Override the path to directory with a build.
export TRAVIS_BUILD_DIR="$CWD/$DRUPAL_TEST_MODULE_LOCATION/$DRUPAL_TEST_MODULE_NAME"

echo "Ensure the directory for project exists."
mkdir -p "$TRAVIS_BUILD_DIR"

echo "Copy the project."
rsync -ra --delete --exclude="${CWD//$TRAVIS_BUILD_DIR_OLD\//}" "$TRAVIS_BUILD_DIR_OLD" "$TRAVIS_BUILD_DIR"

echo "Discover available coding standards."
phpcs --config-set installed_paths "$(find "$CWD/vendor/" -type f -name "ruleset.xml" -exec dirname {} \; | xargs dirname | uniq | paste -sd "," -)"

echo "Configure Apache web-server."
sudo a2enmod rewrite actions fastcgi alias
sudo service apache2 restart
