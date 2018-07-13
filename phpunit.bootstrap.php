<?php

/**
 * @file
 * Bootstrap Drupal to run PHPUnit tests.
 */

chdir(getenv('DRUPAL_TEST_CWD') . '/' . getenv('DRUPAL_TEST_SUBDIR'));
define('DRUPAL_ROOT', getcwd());

$_SERVER += [
  // Prevent notices.
  'REMOTE_ADDR' => '127.0.0.1',
];

require_once DRUPAL_ROOT . '/../vendor/autoload.php';
require_once DRUPAL_ROOT . '/includes/bootstrap.inc';

drupal_bootstrap(DRUPAL_BOOTSTRAP_FULL);
