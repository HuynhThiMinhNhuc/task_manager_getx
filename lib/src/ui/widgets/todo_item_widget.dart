import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_todo/src/app/config/app_color.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    Key? key,
    required this.id,
    this.title = '',
    this.description,
    this.dueDate,
    this.isComplete = false,
    this.onTapItem,
    this.onCheck,
    this.onDismissed,
  }) : super(key: key);

  final int id;
  final String title;
  final String? description;
  final String? dueDate;
  final bool isComplete;
  final Function? onTapItem;
  final Function? onCheck;
  final Function? onDismissed;

  Color _getColor(Set<WidgetState> states) {
    return AppColor.primary;
  }

  Future<bool> _confirmDismiss(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false, // Prevents tapping outside to dismiss
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text(
                "delete_task_title".tr,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              content: Text(
                "delete_task_content".tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(
                    "cancel".tr,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: AppColor.primary),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  child: Text(
                    "delete".tr,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: AppColor.red),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id.toString()),
      confirmDismiss: (direction) => _confirmDismiss(context),
      onDismissed: (direction) {
        onDismissed?.call();
      },
      background: Container(color: AppColor.red),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.w),
        ),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                trailing: Checkbox(
                  key: Key(id.toString() + "checkbox"),
                  checkColor: Theme.of(context).scaffoldBackgroundColor,
                  fillColor: WidgetStateProperty.resolveWith(_getColor),
                  value: isComplete,
                  shape: const CircleBorder(),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  onChanged: (bool? value) {
                    onCheck?.call();
                  },
                ),
                title: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    decoration:
                        isComplete
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                  ),
                ),
                subtitle:
                    description != null && description!.isNotEmpty
                        ? Text(
                          description ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                        : null,
                onTap: () {
                  onTapItem?.call();
                },
              ),
              Divider(height: 0, thickness: 0.5, indent: 16.w, endIndent: 16.w),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Text(
                    dueDate ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
