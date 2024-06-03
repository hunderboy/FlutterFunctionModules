import 'package:flutter/material.dart';
import 'package:flutter_function_modules/lobby.dart';
import 'package:lottie/lottie.dart';


class LottiSplashScreen extends StatefulWidget {
  const LottiSplashScreen({Key? key}) : super(key: key);

  @override
  _LottiSplashScreenState createState() => _LottiSplashScreenState();
}

class _LottiSplashScreenState extends State<LottiSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    /// 화면이 시작되고 몇초간의 딜레이 후, 다음 화면으로 넘어가는 부분
    Future.delayed(
      const Duration(seconds: 1),
            () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Lobby()
                ), (route) => false)
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Lottie.asset(
          // 'assets/lottie/test.json',
          // 'assets/lottie/lf20_uekpwrsv.json',
          "assets/lottie/8546-aperture-logo-loading.json",
          controller: _controller, onLoaded: (composition) {
            _controller.addStatusListener((status) {
              // 애니메이션이 사라지면 다시 생성
              if (status == AnimationStatus.dismissed) {
                _controller.forward();
              } else if (status == AnimationStatus.completed){
                _controller.reverse();
              }
            });

            // Configure the AnimationController with the duration of the
            // Lottie file and start the animation.
            _controller
              ..duration = composition.duration
              ..forward();
          }
        )
      )
    );
  }
}