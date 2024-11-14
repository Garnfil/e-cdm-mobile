import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date, String? format) {
    date ??= DateTime.now();
    format ??= "dd-MMM-yyyy";
    return DateFormat(format).format(date);
  }
}
