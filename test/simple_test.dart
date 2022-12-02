import 'package:flutter_test/flutter_test.dart';

void main() {
  // 어떤 테스트를 할지 설명하고,안에 있는 테스트를 실행합니다.
  test('should be lowercase', () {
    String hello = "Hello World";

    // 테스트를 실행했을 때의 기대값과 실제값을 비교합니다.
    expect(hello.toLowerCase(), "hellKKKKK world");
  });
}