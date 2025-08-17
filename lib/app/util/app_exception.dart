// lib/app/util/app_exception.dart
class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}
