<?php

/**
 * @file
 * Bootstrap Drupal to run PHPUnit tests.
 */

// @todo Read "drupal" from "composer.json" or "DRUPAL_TEST_SUBDIR" variable.
define('DRUPAL_ROOT', getcwd() . '/tests/travis/drupal');

var_dump(
  $_ENV,
  getenv(),
  getenv('DRUPAL_TEST_SUBDIR')
);

$_SERVER += [
  // Prevent notices.
  'REMOTE_ADDR' => '127.0.0.1',
];

require_once DRUPAL_ROOT . '/../vendor/autoload.php';
require_once DRUPAL_ROOT . '/includes/bootstrap.inc';

drupal_bootstrap(DRUPAL_BOOTSTRAP_FULL);
