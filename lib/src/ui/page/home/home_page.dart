import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_todo/src/app/config/app_color.dart';
import 'package:getx_todo/src/app/config/app_keys.dart';
import 'package:getx_todo/src/ui/page/home/home_controller.dart';
import 'package:getx_todo/src/ui/widgets/app_bar.dart';
import 'package:getx_todo/src/ui/widgets/app_dialog.dart';
import 'package:getx_todo/src/ui/widgets/empty_msg.dart';
import 'package:getx_todo/src/ui/widgets/snack_bar.dart';
import 'package:getx_todo/src/ui/widgets/todo_item_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToDoAppBar(title: 'all_todo'.tr),
      backgroundColor: AppColor.greyBackground,
      body: Obx(
        () =>
            controller.todos.isEmpty
                ? EmptyMsg(msg: 'task_empty'.tr)
                : ListView.builder(
                  padding: EdgeInsets.only(
                    top: 8.w,
                    left: 8.w,
                    right: 8.w,
                    bottom: 70.w,
                  ),
                  itemCount: controller.todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.todos[index];
                    return TodoItemWidget(
                      key: Key('todoCell${item.id}'),
                      id: item.id ?? 0,
                      title: item.title,
                      description: item.description,
                      dueDate: item.dueDate,
                      isComplete: item.isComplete,
                      onTapItem:
                          () => {
                            showAppDialog(
                              context,

                              onSubmit:
                                  ({
                                    String? description,
                                    required DateTime dueDate,
                                    required String title,
                                  }) => {
                                    controller.updateTodoItem(
                                      item,
                                      title: title,
                                      description: description,
                                      dueDate: dueDate,
                                      onComplete:
                                          (success, msg) => {
                                            showMessage(msg, success),
                                          },
                                    ),
                                  },
                              item: item,
                            ),
                          },
                      onCheck:
                          () => {
                            controller.updateTodoItem(
                              item,
                              isComplete: !item.isComplete,
                            ),
                          },
                      onDismissed:
                          () => {
                            controller.deleteTodoItem(
                              item,
                              onComplete:
                                  (success, msg) => {showMessage(msg, success)},
                            ),
                          },
                    );
                  },
                ),
      ),
      floatingActionButton: FloatingActionButton(
        key: AppWidgetKeys.addButton,
        onPressed: () {
          showAppDialog(
            context,
            onSubmit: ({
              String? description,
              required DateTime dueDate,
              required String title,
            }) {
              controller.addTodoItem(
                title,
                dueDate,
                description: description,
                onComplete: (success, msg) => {showMessage(msg, success)},
              );
            },
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add, size: 35.w),
      ),
    );
  }
}
