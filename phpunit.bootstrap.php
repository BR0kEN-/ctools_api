<?php

/**
 * @file
 * Bootstrap Drupal to run PHPUnit tests.
 */

// Both environment variables are provided by the ".travis.yml".
if (!chdir(vsprintf('%s/%s', array_map('getenv', ['DRUPAL_TEST_CWD', 'DRUPAL_TEST_SUBDIR'])))) {
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
