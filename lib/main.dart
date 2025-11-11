import 'package:flutter/material.dart';
import 'package:flutter_function_modules/kakao_img_search_api/kakao_img_search_screen.dart';
import 'package:flutter_function_modules/splash/lotti_splash_screen.dart';
import 'package:flutter_function_modules/permission_handler/ready.dart';
import 'package:flutter_function_modules/video_player/video_swiching/video_swiching_demo.dart';
import 'sleekCircularSlider_custom_made/custom_circle_dial_indicator.dart';
import 'lobby.dart';
import 'permission_handler/permission_handler_page.dart';
import 'package:flutter/services.dart';

import 'retrofit_dio_json/retrofit_dio_json.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    /// 상태파 컬러 앱 전체 적용
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark, /// ios 상태바 텍스트 컬러 = white
        )
    );

    return MaterialApp(
        title: 'Flutter Function Module',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Pretendard',   /// 전체 Text 폰트 적용
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const LottiSplashScreen(),
          '/': (context) => Lobby(),
          '/lobby': (context) => Lobby(),
          '/kakao_img_search_api': (context) => KakaoImgSearchScreen(),
          '/retrofit_dio_json': (context) => RetrofitDioJson(),
          '/permission_handler': (context) => const PermissionHandlerPage(),
          '/sleekCircularSlider_custom_made': (context) => const CustomCircleDialIndicator(),
          '/Ready': (context) => const Ready(),
          '/VideoSwichingDemo': (context) => VideoSwichingDemo(),
        },
    );

  }
}