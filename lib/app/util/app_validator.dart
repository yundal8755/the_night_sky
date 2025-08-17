class AppValidator {
  /// EMAIL
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력해주세요.';
    }
    // 간단한 정규식 검사 예시
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return '이메일 형식이 올바르지 않습니다.';
    }
    return null; // 에러 없으면 null
  }

  /// PASSWORD
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    }
    if (value.length < 6) {
      return '비밀번호는 최소 6자리 이상이어야 합니다.';
    }
    return null;
  }
}
