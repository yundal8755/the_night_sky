import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLog {
  // Logger 패키지 인스턴스를 내부에서 사용
  static final Logger _logger = Logger(
    // 릴리즈 모드에서는 로그를 남기지 않는다.
    level: kReleaseMode ? Level.off : Level.debug,

    printer: PrettyPrinter(
      methodCount: 2, // 스택 트레이스에서 몇 단계까지 표시할지
      errorMethodCount: 8, // 에러 발생 시 스택 트레이스 몇 단계까지
      lineLength: 100,
      colors: true,
      printEmojis: true,
      // printTime: false, // 사용 불가 (Deprecated)
      dateTimeFormat: DateTimeFormat.none,
    ),
  );

  /// Debug 로그
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Info 로그
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Warning 로그
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Error 로그
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
