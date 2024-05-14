import 'package:flutter/material.dart';
import 'package:flutter_function_modules/animated_container/test_page_animated_container.dart';
import 'package:flutter_function_modules/custom_intro_slide/onboarding_screen.dart';
import 'package:flutter_function_modules/indexed_stack/test_page_indexedstack.dart';
import 'package:flutter_function_modules/keyboard_test/test_page_keyboard.dart';
import 'package:flutter_function_modules/radio_button/test_page_radio_button.dart';
import 'package:get/get.dart';
import 'package:flutter_function_modules/permission_handler/permission_handler_page.dart';

import 'dialog/custom_dialog.dart';



class Lobby extends StatelessWidget {
  Lobby({Key? key}) : super(key: key);


  final commonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.redAccent,
  );
  final todoStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black,
    backgroundColor: Colors.greenAccent,
  );

  void navigateToTestPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Function Module'),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(14),
          child: ListView(
            primary: true, // 리스트 스크롤 허용
            shrinkWrap: true, // 아이템 수만큼 높이 설정
            children: <Widget>[
              /// todo: 비디오 기능 테스트 화면 따로 관리 해야함.
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lightGreen, // foreground
                  ),
                  child: const Text("운동 플레이 기능 테스트 화면"),
                  onPressed: null // 버튼 비활성화 처리
                  // onPressed: () {
                  //   // Get.toNamed("/TestPlayVideo");
                  //   // Get.toNamed("/TestAssetsVideo");
                  //   // Get.toNamed("/TestVideoPlayerApp");
                  //   // Get.toNamed("/TestPlayerStateful");
                  //   // Get.toNamed("/TestAnimation");
                  //   // Get.toNamed("/TestListAnimation");
                  //   Get.toNamed("/VideoSwichingDemo");
                  //   // Get.toNamed("/VideoSwichingWithGetxVer2");
                  //   /// Landscape play video 테스트
                  //   // Get.toNamed("/LandscapePlayer");
                  // },
                ),
              ),

              ElevatedButton(
                child: const Text("kakao_img_search_api"),
                onPressed: () {
                  Get.toNamed("/kakao_img_search_api");
                },
              ),
              ElevatedButton(
                child: const Text("retrofit_dio_json"),
                onPressed: () {
                  Get.toNamed("/retrofit_dio_json");
                },
              ),
              /// 권한 예제
              ElevatedButton(
                child: const Text("permission_handler"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PermissionHandlerPage()),
                  );
                },
              ),
              /// sleekCircularSlider_custom_made
              ElevatedButton(
                child: const Text("sleekCircularSlider_custom_made"),
                onPressed: () {
                  Get.toNamed("/sleekCircularSlider_custom_made");
                },
              ),
              /// animated_container
              ElevatedButton(
                onPressed: () {
                  navigateToTestPage(context, const TestPageAnimatedContainer());
                },
                child: const Text('animated_container'),
              ),
              ElevatedButton(
                onPressed: () {
                  navigateToTestPage(context, const TestPageIndexedStack());
                },
                child: const Text('IndexedStack - BottomNavigationBar'),
              ),
              ElevatedButton(
                onPressed: () {
                  navigateToTestPage(context, const TestPageRadioButton());
                },
                child: const Text('Radio Button'),
              ),
              ElevatedButton(
                onPressed: () {
                  navigateToTestPage(context, const TestPageKeyboard());
                },
                child: const Text('Keyboard Test'),
              ),
              ElevatedButton(
                onPressed: () {
                  navigateToTestPage(context, const OnBoardingScreen());
                },
                child: const Text('Custom Intro Slide'),
              ),



/// Todo ---------------------------------------------------------------------
              Container(
                color: Colors.greenAccent,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Todo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              ElevatedButton(
                style: todoStyle,
                onPressed: () {

                },
                child: const Text('해야할 모듈 작업'),
              ),
            ],
          ),
        )
      ),
    );
  }
}