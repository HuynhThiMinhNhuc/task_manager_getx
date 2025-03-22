import 'package:getx_todo/src/app/config/app_constant.dart';

class TodoItem {
  TodoItem({
    this.id,
    required this.title,
    required this.createdAt,
    this.description,
    required this.dueDate,
    this.updatedAt,
    this.isComplete = false,
  });

  int? id;
  String title;
  String? description;
  String dueDate;
  String createdAt;
  String? updatedAt;
  bool isComplete;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      AppConstant.columnTitle: title,
      AppConstant.columnStatus: isComplete == true ? 1 : 0,
      AppConstant.collumnDescription: description,
      AppConstant.columnDueDate: dueDate,
      AppConstant.createdAt: createdAt,
      AppConstant.updatedAt: updatedAt,
    };
    if (id != null) {
      map[AppConstant.columnId] = id;
    }
    return map;
  }

  factory TodoItem.fromMap(Map<dynamic, dynamic> map) {
    return TodoItem(
      id: map[AppConstant.columnId],
      title: map[AppConstant.columnTitle],
      isComplete: map[AppConstant.columnStatus] == 1,
      description: map[AppConstant.collumnDescription],
      dueDate: map[AppConstant.columnDueDate],
      createdAt: map[AppConstant.createdAt],
      updatedAt: map[AppConstant.updatedAt],
    );
  }
}
