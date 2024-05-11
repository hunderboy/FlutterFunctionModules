import 'package:flutter/material.dart';
import 'package:flutter_function_modules/kakao_img_search_api/kakao_img_search_screen.dart';
import 'package:flutter_function_modules/splash/lotti_splash_screen.dart';
import 'package:flutter_function_modules/permission_handler/ready.dart';
import 'package:flutter_function_modules/video_player/video_swiching/video_swiching_demo.dart';
import 'package:get/get.dart';
import 'page/change_status_bar.dart';
import 'page/custom_circle_dial_indicator.dart';
import 'lobby.dart';
import 'permission_handler/permission_handler_page.dart';
import 'package:flutter/services.dart';

import 'retrofit_dio_json/retrofit_dio_json.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    /// 상태파 컬러 앱 전체 적용
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark, /// ios 상태바 텍스트 컬러 = white
        )
    );

    return GetMaterialApp(
        title: 'Flutter Function Module',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Pretendard',   /// 전체 Text 폰트 적용
        ),
        initialRoute: "/lotti_splash",

        getPages: [

          GetPage( /// 앱 첫 시작 로딩페이지
              name: "/lotti_splash",
              page: () => const LottiSplashScreen(),
              curve: const Cubic(0.4, 0.0, 0.4, 0.0),
              transition: Transition.rightToLeft),

          GetPage(
              name: "/",
              page: () => const Lobby(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/kakao_img_search_screen",
              page: () => KakaoImgSearchScreen(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/Retrofit_Dio_Json",
              page: () => RetrofitDioJson(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/CustomCircleDialIndicator",
              page: () => const CustomCircleDialIndicator(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/PermissionHandler",
              page: () => const PermissionHandlerPage(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/Ready",
              page: () => const Ready(),
              transition: Transition.rightToLeft),
          GetPage(
              name: "/ChangeStatusBar",
              page: () => const ChangeStatusBar(),
              transition: Transition.rightToLeft),

          /// 비디오플레이어 테스트
          GetPage(
              name: "/VideoSwichingDemo",
              page: () => VideoSwichingDemo(),
              transition: Transition.rightToLeft),
        ]
    );

  }
}