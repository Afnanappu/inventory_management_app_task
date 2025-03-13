import 'package:intl/intl.dart';

/// Formats the given [DateTime] into a string of the format 'dd/MM/yy'
///
/// Example: 08/02/25
String formatDateTime({required DateTime date}) {
  return DateFormat('dd/MM/yy').format(date);
}

/// Formats the given [DateTime] into a string of the format 'MMM dd, yyyy'
///
/// Example: Feb 08, 2025
String formatDateTime2({required DateTime date}) {
  return DateFormat('MMM dd, yyyy').format(date);
}

/// Formats the given [DateTime] into a string of the format 'yyyy-MM-dd HH:mm'
///
/// Example: 2025-02-08 15:10
///
String formatDateTime3({required DateTime date}) {
  return DateFormat('yyyy-MM-dd HH:mm').format(date);
}
