<?php
/**
 * @file
 * Helper for Customizable Region and Page style plugins.
 */

namespace CTools\Plugins\Styles;

use CTools\Form;

/**
 * Class Customizable.
 *
 * @package CTools\Plugins\Styles
 */
abstract class Customizable implements StylesInterface {

  /**
   * {@inheritdoc}
   */
  public static function info() {
    return [];
  }

  /**
   * {@inheritdoc}
   */
  public static function themeVariants() {
    return [];
  }

  /**
   * {@inheritdoc}
   */
  public static function dependencies() {
    return [];
  }

  /**
   * {@inheritdoc}
   */
  public static function configurationFormSubmit(array &$form, array &$form_state, array &$conf) {

  }

  /**
   * {@inheritdoc}
   */
  public static function configurationFormElementCallback(array &$form, array &$form_state, array &$conf, array &$commands, array $element) {

  }

  /**
   * Process settings.
   *
   * @param string[] $parents
   *   Nesting names.
   * @param array $settings
   *   Values from configuration form.
   */
  protected static function processSettings(array $parents, array &$settings) {
    $values =& drupal_array_get_nested_value($settings, $parents);
    $attributes = [];

    foreach ($values['attributes'] as $i => $item) {
      $attributes[$item['attribute']] = $item['value'];
    }

    $values['attributes'] = array_filter($attributes);
  }

  /**
   * Construct form item for configuring HTML tag and attributes.
   *
   * @param string[] $parents
   *   Nesting names.
   * @param array $form
   *   Form elements implementation.
   * @param array $form_state
   *   Drupal form state.
   * @param array $conf
   *   Values from configuration form.
   * @param string[] $tags
   *   HTML tag names.
   */
  protected static function formItem(array $parents, array &$form, array &$form_state, array $conf, array $tags) {
    drupal_array_set_nested_value($form, array_merge($parents, ['tag']), [
      '#type' => 'select',
      '#title' => t('HTML tag'),
      '#options' => drupal_map_assoc($tags),
    ]);

    new Form\Elements\Collection(array_merge($parents, ['attributes']), $form, $form_state, $conf, function () {
      $item = [];

      $item['attribute'] = [
        '#type' => 'textfield',
        '#title' => t('Attribute'),
      ];

      $item['value'] = [
        '#type' => 'textfield',
        '#title' => t('Value'),
      ];

      return $item;
    });
  }

}