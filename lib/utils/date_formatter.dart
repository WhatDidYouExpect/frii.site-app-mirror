import 'package:intl/intl.dart';

String formatDate(dynamic dateValue) {
  if (dateValue == null) return 'Unknown';
  try {
    DateTime dateTime;
    if (dateValue is int) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(dateValue * 1000);
    } else if (dateValue is String) {
      dateTime = DateTime.parse(dateValue);
    } else {
      return dateValue.toString();
    }
    return DateFormat.yMMMMEEEEd().add_jm().format(dateTime.toLocal());
  } catch (e) {
    return dateValue.toString();
  }
}
