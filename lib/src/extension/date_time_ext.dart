import 'package:getx_todo/src/app/config/app_constant.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String toMMddyyyy() {
    return DateFormat(AppConstant.dateTimeFormat).format(this);
  }
}
