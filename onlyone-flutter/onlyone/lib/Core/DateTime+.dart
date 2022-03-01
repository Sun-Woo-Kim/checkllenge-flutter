extension DateTimeExtension on DateTime {
  DateTime removedTime() {
    return DateTime(year, month, day);
  }
}
