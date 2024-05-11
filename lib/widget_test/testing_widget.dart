import 'package:flutter/material.dart';



/// widget Test 를 위한 위젯코드
/// todo: 블로그 작성을 위해 수정될 예정
class MyWidget extends StatelessWidget {
  final String title;
  final String message;

  const MyWidget({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}