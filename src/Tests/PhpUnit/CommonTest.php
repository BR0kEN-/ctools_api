<?php

namespace Drupal\Tests\ctools_api\PhpUnit;

class CommonTest extends \PHPUnit_Framework_TestCase {

  /**
   * @dataProvider providerToUnderscore
   */
  public function testToUnderscore($value, $expected) {
    static::assertSame($expected, ctools_api_to_underscore($value));
  }

  public function providerToUnderscore() {
    return [
      ['MyCamelCaseString', 'my_camel_case_string'],
    ];
  }

}
