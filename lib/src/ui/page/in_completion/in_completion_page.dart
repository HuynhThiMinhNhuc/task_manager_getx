import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_todo/src/app/config/app_color.dart';
import 'package:getx_todo/src/ui/page/in_completion/in_completion_controller.dart';
import 'package:getx_todo/src/ui/widgets/app_bar.dart';
import 'package:getx_todo/src/ui/widgets/app_dialog.dart';
import 'package:getx_todo/src/ui/widgets/empty_msg.dart';
import 'package:getx_todo/src/ui/widgets/snack_bar.dart';
import 'package:getx_todo/src/ui/widgets/todo_item_widget.dart';

class InCompletionPage extends GetView<InCompletionController> {
  const InCompletionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToDoAppBar(title: 'all_incomplete'.tr),
      backgroundColor: AppColor.greyBackground,
      body: Obx(
        () =>
            controller.todoInCompleteds.isEmpty
                ? EmptyMsg(msg: 'task_complete_empty'.tr)
                : ListView.builder(
                  padding: EdgeInsets.all(8.w),
                  itemCount: controller.todoInCompleteds.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.todoInCompleteds[index];
                    return TodoItemWidget(
                      key: Key('todoCell${item.id}'),
                      id: item.id,
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
                                    controller.homeController.updateTodoItem(
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
                            controller.homeController.updateTodoItem(
                              item,
                              isComplete: !item.isComplete,
                            ),
                          },
                      onDismissed:
                          () => {
                            controller.homeController.deleteTodoItem(
                              item,
                              onComplete:
                                  (success, msg) => {showMessage(msg, success)},
                            ),
                          },
                    );
                  },
                ),
      ),
    );
  }
}
