import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller_test_list_animation.dart';




class TestListAnimation extends GetView<ControllerTestListAnimation>  {
  const TestListAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerTestListAnimation());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              GetBuilder<ControllerTestListAnimation>(
                // id: "first",  // id 를 부여한 순간 부터 이것과 연결된것만 영향을 주거나 받을수있다.
                  builder: (controller) {
                    return
                      Visibility(
                        child: Text('이 글자를 안보이게 하고 싶습니다.', style: Theme.of(context).textTheme.headline6,),
                        visible: controller.visibility,
                      );
                  }
              ),

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
                child:
                ElevatedButton(
                  child: const Text("일시정지"),
                  style:
                  ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.redAccent,
                    onPrimary: Colors.white,          // 글자색
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    controller.stop();
                  },
                ),
              ),
              const Divider(color: Colors.blue, height: 1),
              Expanded(
                child: Obx(() =>
                    ListView.builder(
                      controller: controller.listScrollController, // 리스트 스크롤 컨트롤러
                      primary: false, // 리스트 스크롤 허용
                      itemCount: controller.exerciseList.length+1, // 리스트 개수 +1
                      shrinkWrap: true, // 아이템 수만큼 높이 설정
                      itemBuilder: (BuildContext context, int index) {  /// index 는 0 부터..

                        /// 아이템 인덱스가 최종 하단에 갔을 경우
                        if(index == controller.exerciseList.length){
                          return _EmptyAreaItem(
                            /// 테스트 기기 아이폰 12. 대충 재서 임의값으로 200 할당
                            minusHeight: 200,  // 기기 높이 - minusHeight
                          );
                        }else{
                          return _TodayPlanListItem(
                              title: controller.exerciseList[index].title,
                              remainingTimeText: controller.exerciseList[index].rxRemainingTimeText.value,
                              progress: controller.exerciseList[index].rxProgress.value
                          );
                        }
                      },),
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

        const Divider(color: Colors.black38, height: 1,),

      ],
    );
  }

}

class _EmptyAreaItem extends StatelessWidget {
  _EmptyAreaItem({Key? key, required this.minusHeight}) : super(key: key);
  double minusHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - minusHeight,
      color: Colors.grey,
    );
  }

}