import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_function_modules/permission_handler/permission_handler_page.dart';

import 'dialog/custom_dialog.dart';



class Lobby extends StatelessWidget {
  const Lobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Function Module'),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView(
                  primary: true, // 리스트 스크롤 허용
                  shrinkWrap: true, // 아이템 수만큼 높이 설정
                  children: <Widget>[

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



                    /// 비디오 기능 테스트 화면
                    /// todo: 따로 관리 해야함.
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.lightGreen, // foreground
                        ),
                        child: const Text("운동 플레이 기능 테스트 화면"),
                        onPressed: () {
                          // Get.toNamed("/TestPlayVideo");
                          // Get.toNamed("/TestAssetsVideo");
                          // Get.toNamed("/TestVideoPlayerApp");
                          // Get.toNamed("/TestPlayerStateful");
                          // Get.toNamed("/TestAnimation");
                          // Get.toNamed("/TestListAnimation");
                          Get.toNamed("/VideoSwichingDemo");
                          // Get.toNamed("/VideoSwichingWithGetxVer2");
                          /// Landscape play video 테스트
                          // Get.toNamed("/LandscapePlayer");
                        },
                      ),
                    )

                  ],
                ),
              ],
            ),
          )
        )
      ),
    );

  }
}