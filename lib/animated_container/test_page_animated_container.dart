import 'dart:math';
import 'package:flutter/material.dart';



class TestPageAnimatedContainer extends StatefulWidget {
  const TestPageAnimatedContainer({Key? key}) : super(key: key);

  @override
  _TestPageAnimatedContainerState createState() => _TestPageAnimatedContainerState();
}

class _TestPageAnimatedContainerState extends State<TestPageAnimatedContainer> {
  // AnimatedContainer의 기본 속성을 설정할 변수를 할당.
  // FloatingActionButton을 탭하면 다음 값을 랜덤하게 변경하여 AnimatedContainer 를 변경
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainer Demo'),
      ),
      body: Center(
        child: AnimatedContainer(
          // State 클래스에서 선언한 변수로 속성 설정
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: _borderRadius,
          ),
          // 애니메이션 시간 설정
          duration: const Duration(seconds: 1),
          // 애니메이션이 부드럽게 변화는 효과 옵션설정
          curve: Curves.fastOutSlowIn,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // 버튼을 탭하면
        onPressed: () {
          // setState 메서드를 통해 위젯을 다시 로드
          setState(() {
            // 랜덤 객체 생성
            final random = Random();

            // 300이내의 랜덤 정수 생성 후 double 타입으로 변경, 할당
            _width = random.nextInt(300).toDouble();
            _height = random.nextInt(300).toDouble();

            // RGB 색상을 랜덤하게 생성
            _color = Color.fromRGBO(
              random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256),
              1,
            );

            // 모서리 곡률을 랜덤하게 설정
            _borderRadius =
                BorderRadius.circular(random.nextInt(100).toDouble());
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}