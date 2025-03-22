import 'package:flutter/material.dart';

abstract class AppWidgetKeys {
  static const addButton = Key('add_button_key');
  static const dialog = Key('dialog_key');
  static const dialogTitle = Key('dialog_title_key');
  static const dialogTextFieldTitle = Key('dialog_text_field_title_key');
  static const dialogTextFieldDescription = Key(
    'dialog_text_field_description_key',
  );
  static const dialogTextFieldDueDate = Key('dialog_text_field_due_date_key');
}
