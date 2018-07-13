<?php

namespace Drupal\Tests\ctools_api\PhpUnit;

/**
 * The set of tests of common module functionality.
 */
class CommonTest extends \PHPUnit_Framework_TestCase {

  /**
   * Tests transformation of strings to the "underscore" format.
   *
   * @param string $input
   *   The initial value to transform.
   * @param string $expected
   *   The value that's expected after processing.
   *
   * @dataProvider providerToUnderscore
   */
  public function testToUnderscore($input, $expected) {
    static::assertSame($expected, ctools_api_to_underscore($input));
  }

  /**
   * {@inheritdoc}
   */
  public function providerToUnderscore() {
    return [
      ['MyCamelCaseString', 'my_camel_case_string'],
    ];
  }

}
