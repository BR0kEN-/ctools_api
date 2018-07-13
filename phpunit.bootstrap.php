<?php

/**
 * @file
 * Bootstrap Drupal to run PHPUnit tests.
 *
 * @see phpunit.xml
 */

$paths = [];

// Both environment variables are provided by the ".travis.yml".
foreach (['DRUPAL_TEST_CWD', 'DRUPAL_TEST_COREDIR'] as $variable) {
  $path = getenv($variable);

  if (empty($path)) {
    throw new \RuntimeException(sprintf('The "%s" environment variable either missing or undefined.', $variable));
  }

  $paths[] = $path;
}

if (!chdir(vsprintf('%s/%s', $paths))) {
  throw new \RuntimeException('The environment to run PHPUnit is not configured!');
}

define('DRUPAL_ROOT', getcwd());

$_SERVER += [
  // Prevent notices.
  'REMOTE_ADDR' => '127.0.0.1',
];

require_once DRUPAL_ROOT . '/../vendor/autoload.php';
require_once DRUPAL_ROOT . '/includes/bootstrap.inc';

drupal_bootstrap(DRUPAL_BOOTSTRAP_FULL);
