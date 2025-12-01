import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toFormattedDate() => DateFormat('MMM dd, yyyy').format(this);
  String toFormattedDateTime() => DateFormat('MMM dd, yyyy - hh:mm a').format(this);
  String toFormattedTime() => DateFormat('hh:mm a').format(this);
}

extension StringExtension on String {
  String capitalize() => isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
  bool isValidEmail() => RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(this);
}

extension DoubleExtension on double {
  String toFormattedPrice() => '₹${toStringAsFixed(2)}';
  String toPercentage() => '${toStringAsFixed(1)}%';
}
