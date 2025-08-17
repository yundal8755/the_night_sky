import 'package:intl/intl.dart';

class AppDate {
  /// 1) yyyy.MM.dd 형식 (예: 2025.04.02)
  static String yyyyMMdd(DateTime date) {
    return DateFormat('yyyy.MM.dd').format(date);
  }

  /// 2) yyyy.MM.dd(화) 요일 한글 축약 (예: 2025.04.02(화))
  static String yyyyMMddW(DateTime date) {
    final dateStr = DateFormat('yyyy.MM.dd').format(date);
    final weekday = _korWeekdayShort(date.weekday);
    return '$dateStr($weekday)';
  }

  /// 3) yyyy-MM-dd HH:mm (24시간) (예: 2025-04-02 17:45)
  static String yyyyMdHm24(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }

  /// 4) yyyy-MM-dd a hh:mm (12시간) (예: 2025-04-02 오후 05:45)
  static String yyyyMdHm12(DateTime date) {
    return DateFormat('yyyy-MM-dd a hh:mm').format(date);
  }

  /// 5) MMM d, yyyy (영문 월 표기, 예: Apr 2, 2025)
  static String engMdy(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  /// 6) yyyy년 M월 d일 (예: 2025년 4월 2일)
  static String koYmd(DateTime date) {
    return DateFormat('yyyy년 M월 d일').format(date);
  }

  /// 7) M월 d일 EEEE, HH시 mm분 (예: 4월 2일 수요일, 17시 45분)
  static String koMdW24(DateTime date) {
    final formatter = DateFormat('M월 d일 EEEE, HH시 mm분', 'ko_KR');
    return formatter.format(date);
  }

  /// 8) M월 d일 EEEE, a hh시 mm분 (예: 4월 2일 수요일, 오후 05시 45분)
  static String koMdW12(DateTime date) {
    final formatter = DateFormat('M월 d일 EEEE, a hh시 mm분', 'ko_KR');
    return formatter.format(date);
  }

  /// 9) EEEE (요일 전부, 예: 수요일)
  static String koWeekdayFull(DateTime date) {
    return DateFormat('EEEE', 'ko_KR').format(date);
  }

  /// 10) yyyy.MM.dd (EEE) a hh:mm:ss (예: 2025.04.02 (수) 오후 05:45:12)
  static String yMdW12Sec(DateTime date) {
    final datePart = DateFormat('yyyy.MM.dd').format(date);
    final weekdayPart = DateFormat('EEE', 'ko_KR').format(date);
    final timePart = DateFormat('a hh:mm:ss').format(date);
    return '$datePart ($weekdayPart) $timePart';
  }

  /// 11) yyyy년 M월 d일 (EEE) HH:mm:ss (예: 2025년 4월 2일 (수) 17:45:12)
  static String koYmdW24Sec(DateTime date) {
    final datePart = DateFormat('yyyy년 M월 d일').format(date);
    final weekdayPart = DateFormat('EEE', 'ko_KR').format(date);
    final timePart = DateFormat('HH:mm:ss').format(date);
    return '$datePart ($weekdayPart) $timePart';
  }

  /// 12) a hh:mm (예: 오후 05:45)
  static String time12(DateTime date) {
    return DateFormat('a hh:mm').format(date);
  }

  /// 13) HH:mm:ss (예: 17:45:12)
  static String time24Sec(DateTime date) {
    return DateFormat('HH:mm:ss').format(date);
  }

  /// 14) yyyy/MM/dd (예: 2025/04/02)
  static String yyyyMdSlash(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  /// 15) 특수 케이스(분기): 2025년 Q2 분기
  static String yearQuarter(DateTime date) {
    final quarter = ((date.month - 1) ~/ 3) + 1;
    final yearStr = DateFormat('yyyy년').format(date);
    return '$yearStr Q$quarter 분기';
  }

  /// 16) yMd() 빌트인 (예: 4/2/2025) - locale 따라 자동 변환
  static String builtInYmd(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  /// 요일 보조 메서드 (1=월 ~ 7=일)
  static String _korWeekdayShort(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return '월';
      case DateTime.tuesday:
        return '화';
      case DateTime.wednesday:
        return '수';
      case DateTime.thursday:
        return '목';
      case DateTime.friday:
        return '금';
      case DateTime.saturday:
        return '토';
      case DateTime.sunday:
        return '일';
      default:
        return '';
    }
  }
}
