import 'package:intl/intl.dart';

String formatDateTime({required DateTime date}) {
  return DateFormat('dd/MM/yy').format(date);
}
