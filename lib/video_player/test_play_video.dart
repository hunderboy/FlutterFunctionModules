import 'package:flutter/material.dart';
import 'package:flutter_function_modules/getx_controller/controller_test_play_video.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';


class TestPlayVideo extends GetView<ControllerTestPlayVideo> {
  const TestPlayVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerTestPlayVideo());

    print(controller.playerController);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 비디오 플레이어
              // Container(
              //   child: AspectRatio(
              //     aspectRatio: 16 / 9, // 영상 비율(16:9)에 맞춤 : controller.playerController.value.aspectRatio
              //     child: Stack(
              //       alignment: Alignment.bottomCenter,
              //       children: <Widget>[
              //         VideoPlayer(controller.playerController),
              //         _ControlsOverlay(getxController: controller),
              //       ],
              //     ),),),

              GetBuilder<ControllerTestPlayVideo>(
                // id: "first",  // id 를 부여한 순간 부터 이것과 연결된것만 영향을 주거나 받을수있다.
                  builder: (controller) {
                    return
                      FutureBuilder(
                          future: controller.initializeVideoPlayerFuture,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              print("정상적으로 영상 데이터 가져옴");
                              return Container(
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  // 영상 비율(16:9)에 맞춤 : controller.playerController.value.aspectRatio
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: <Widget>[
                                      VideoPlayer(controller.playerController),
                                      _ControlsOverlay(getxController: controller),
                                    ],
                                  ),),
                              );
                            }
                            else {
                              print("영상 데이터 불러오는중");
                              return const AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Center(child: CircularProgressIndicator())
                              );
                            }
                          }
                      );
                  }
              ),

              Container(
                child: FlatButton(
                  color: Colors.yellow,
                  onPressed: () {
                    controller.next();
                  },
                  child: Text('다음영상재생'),
                ),
              ),

              Expanded(
                child: Obx(() =>
                    ListView.builder(
                      primary: false, // 리스트 스크롤 허용
                      itemCount: controller.exerciseList.length,
                      shrinkWrap: true, // 아이템 수만큼 높이 설정
                      itemBuilder: (BuildContext context, int index) {  /// index 는 0 부터..
                        return _TodayPlanListItem(
                          title: controller.exerciseList[index].title,
                          remainingTimeText: controller.exerciseList[index].rxRemainingTimeText.value,
                          progress: controller.exerciseList[index].rxProgress.value
                        );
                      },),
                ),
              ),

            ]
        ),),);
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
              Positioned(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: MediaQuery.of(context).size.width * progress,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0x6607BEB8),
                  ),
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   height: 100,
              //   child: LinearProgressIndicator(
              //     value: progress,
              //     color: Color(0x6607BEB8),
              //     backgroundColor: Colors.transparent,
              //   ),
              // ),  // 운동 progress

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




/// 비디오플레이어 컨트롤러
class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.getxController}) : super(key: key);
  // 전달 받은 Getx 컨트롤러
  final ControllerTestPlayVideo getxController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.topRight,
            child: Obx(() {
              return IconButton(
                onPressed: () {
                  getxController.setPlayerState();
                },
                icon: Icon(
                  getxController.isPlayingVideo.value ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                  color: Colors.white,
                  size: 40.0,
                  semanticLabel: 'Play',
                ),
              );
            }),

          ),
        ),
      ],
    );
  }

}