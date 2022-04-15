import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_function_modules/permission_handler/permission_handler_page.dart';

import 'custom_dialog.dart';



class Lobby extends StatelessWidget {
  const Lobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Module'),
      ),
      body: SafeArea(
        child: Center(
          child: 
          Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView(
                  primary: true, // 리스트 스크롤 허용
                  shrinkWrap: true, // 아이템 수만큼 높이 설정
                  children: <Widget>[
                    /// 권한 예제
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PermissionHandlerPage()),
                        );
                      },
                      child: const Text("Permission"),
                    ),
                    /// 다이얼로그 예제
                    ElevatedButton(
                      onPressed: () {
                        showDialog(context: context,
                            builder: (BuildContext context){
                              return const CustomDialog(
                                type : "알림",
                                title: "알림을 켜주세요!",
                                descriptions: "알림을 켜놓으면 운동의 달성률이 높아져 재활치료의 효과가 극대화 됩니다.",
                                negativeText: "나중에",
                                positiveText: "알림 켜기",
                              );
                            }
                        );
                      },
                      child: const Text("Custom Dialog"),
                    ),
                    /// 통증 다이얼 예제
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed("/CustomCircleDialIndicator");
                      },
                      child: const Text("통증 다이얼"),
                    ),
                    /// 화면 상태바 배경 or 텍스트 색상 변경 예제
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed("/ChangeStatusBar");
                      },
                      child: const Text("상태바 변경"),
                    ),
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