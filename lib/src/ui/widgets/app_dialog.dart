import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:getx_todo/src/app/config/app_color.dart';
import 'package:getx_todo/src/app/config/app_keys.dart';
import 'package:getx_todo/src/data/model/todo_item.dart';
import 'package:getx_todo/src/extension/date_time_ext.dart';
import 'package:getx_todo/src/extension/string_ext.dart';

Future<void> showAppDialog(
  BuildContext context, {
  TodoItem? item,
  required Function({
    String? description,
    required String title,
    required DateTime dueDate,
  })
  onSubmit,
}) async {
  final isUpdate = item != null;

  final titleController = TextEditingController(text: item?.title);
  final descController = TextEditingController(text: item?.description);
  final dueDate = ValueNotifier<DateTime>(
    item?.dueDate.toDateTime() ?? DateTime.now(),
  );

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => _TaskDialog(
          isUpdate: isUpdate,
          titleController: titleController,
          descController: descController,
          dueDate: dueDate,
          onSubmit: onSubmit,
        ),
  );
}

class _TaskDialog extends StatefulWidget {
  final bool isUpdate;
  final TextEditingController titleController;
  final TextEditingController descController;
  final ValueNotifier<DateTime?> dueDate;
  final Function({
    String? description,
    required String title,
    required DateTime dueDate,
  })
  onSubmit;

  const _TaskDialog({
    required this.isUpdate,
    required this.titleController,
    required this.descController,
    required this.dueDate,
    required this.onSubmit,
  });

  @override
  State<_TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<_TaskDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    widget.titleController.dispose();
    widget.descController.dispose();
    widget.dueDate.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate() && widget.dueDate.value != null) {
      widget.onSubmit(
        title: widget.titleController.text.trim(),
        description: widget.descController.text.trim(),
        dueDate: widget.dueDate.value!,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: AppWidgetKeys.dialog,
      title: Text(
        widget.isUpdate ? 'update_task'.tr : 'create_task'.tr,
        key: AppWidgetKeys.dialogTitle,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: Colors.black),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogTextField(
              controller: widget.titleController,
              hintText: 'task_title'.tr,
              maxLength: 100,
              key: AppWidgetKeys.dialogTextFieldTitle,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'title_can_not_be_empty'.tr;
                }
                return null;
              },
            ),
            DialogTextField(
              controller: widget.descController,
              hintText: 'task_des'.tr,
              maxLength: 1000,
              maxLines: 2,
              key: AppWidgetKeys.dialogTextFieldDescription,
            ),
            DueDatePicker(dueDate: widget.dueDate),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'cancel'.tr,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: AppColor.red),
          ),
        ),
        TextButton(
          onPressed: _handleSubmit,
          child: Text(
            widget.isUpdate ? 'update'.tr : 'create'.tr,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class DialogTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLength;
  final int maxLines;
  final String? Function(String?)? validator;

  const DialogTextField({
    required this.controller,
    required this.hintText,
    this.maxLength = 100,
    this.maxLines = 1,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      maxLength: maxLength,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.titleSmall,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}

class DueDatePicker extends StatelessWidget {
  final ValueNotifier<DateTime?> dueDate;

  const DueDatePicker({required this.dueDate, Key? key}) : super(key: key);

  void _pickDate(BuildContext context) {
    DatePicker.showDateTimePicker(
      context,
      currentTime: dueDate.value ?? DateTime.now(),
      minTime: DateTime.now(),
      maxTime: DateTime(2100),
      onConfirm: (date) => dueDate.value = date,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => _pickDate(context),
          icon: Icon(
            Icons.calendar_today,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ),
        ValueListenableBuilder<DateTime?>(
          valueListenable: dueDate,
          builder:
              (context, value, child) => Text(
                value == null ? 'task_due_date'.tr : value.toMMddyyyy(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
        ),
      ],
    );
  }
}
