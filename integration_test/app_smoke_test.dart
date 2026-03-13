import 'package:everyones_tone/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('app launches and shows main title', ($) async {
    // 앱 실행
    await $.pumpWidgetAndSettle(
        const app.MyApp()); // app.main() 대신 MyApp() 직접 호출 권장

    // '밤하늘'이라는 텍스트가 화면에 나타날 때까지 최대 10초 대기
    await $('밤하늘').waitUntilVisible(); // 만약 텍스트라면 $('밤하늘')

    expect($('밤하늘'), findsOneWidget);
  });
}
