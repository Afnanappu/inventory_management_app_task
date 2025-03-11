import 'package:intl/intl.dart';

String formatDateTime({required DateTime date}) {
  return DateFormat('dd/MM/yy').format(date);
}
String formatDateTime2({required DateTime date}) {
  return DateFormat('MMM dd, yyyy').format(date);
}
