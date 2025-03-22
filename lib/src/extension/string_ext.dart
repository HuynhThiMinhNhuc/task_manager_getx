import 'package:getx_todo/src/app/config/app_constant.dart';
import 'package:intl/intl.dart';

extension StringExt on String {
  DateTime toDateTime() {
    return DateFormat(AppConstant.dateTimeFormat).parse(this);
  }
}
