import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller_test_animation.dart';



class TestAnimation extends GetView<ControllerTestAnimation>  {
  const TestAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerTestAnimation());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                child:
                ElevatedButton(
                  child: const Text("다음영상재생"),
                  style:
                  ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.yellow,
                    onPrimary: Colors.white,          // 글자색
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    controller.animationStart();
                  },
                ),
              ),
              Container(
                child: Obx(() =>
                    _TodayPlanListItem(
                        title: "타이틀",
                        remainingTimeText: "00:00",
                        progress: controller.rxProgress.value
                    )
                ),
              ),


            ]
        ),
      ),
    );

  }
}


/// 운동 아이템
class _TodayPlanListItem extends StatelessWidget {
  _TodayPlanListItem({Key? key, required this.title, required this.remainingTimeText, required this.progress}) : super(key: key);
  String title;
  String remainingTimeText;
  double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
            children: <Widget>[
              // Positioned(
              //   child: AnimatedContainer(
              //     duration: Duration(milliseconds: 500),
              //     width: MediaQuery.of(context).size.width * progress,
              //     height: 100,
              //     decoration: BoxDecoration(
              //       color: Color(0x6607BEB8),
              //     ),
              //   ),
              // ),
              Container(
                width: double.infinity,
                height: 100,
                child: LinearProgressIndicator(
                  value: progress,
                  color: Color(0x6607BEB8),
                  backgroundColor: Colors.transparent,
                ),
              ),  // 운동 progress

              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child:
                      Text(remainingTimeText, style: TextStyle(fontSize: 18)),  // 운동 타이머
                    ),  // 메인 이미지 운동 제목
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(title, style: TextStyle(fontSize: 15)), // 운동 제목
                            ),  // 메인 이미지 운동 제목
                            // Container(
                            //   child: Text("오른발", style: TextStyle(fontSize: 12)), // 운동 서브 타이틀
                            // ),  // 메인 이미지 운동 시간
                          ]
                      ),
                    ),
                  ],
                ),
              ),

            ]
        ),

      ],
    );
  }

}