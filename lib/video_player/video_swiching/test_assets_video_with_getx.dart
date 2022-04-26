import 'package:flutter/material.dart';
import 'package:flutter_function_modules/video_player/video_swiching/controller_test_assets_video.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';


class TestAssetsVideo extends GetView<ControllerTestAssetsVideo> {
  const TestAssetsVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerTestAssetsVideo());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
            children: [

              /// 비디오 플레이어
              GetBuilder<ControllerTestAssetsVideo>(
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
                    controller.getValuesAndPlay(0,false);
                    print('Video Stream 0');
                  },
                  child: Text('Video Stream 0'),
                ),
              ),
              Container(
                child: FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    controller.getValuesAndPlay(1,false);
                    print('Video Stream 1');
                  },
                  child: Text('Video Stream 1'),
                ),
              ),
              Container(
                child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    controller.getValuesAndPlay(2,false);
                    print('Video Stream 2');
                  },
                  child: Text('Video Stream 2'),
                ),
              )

            ]
        ),),);
  }

}



/// 비디오플레이어 컨트롤러
class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.getxController}) : super(key: key);
  // 전달 받은 Getx 컨트롤러
  final ControllerTestAssetsVideo getxController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.topRight,
            child:
            Obx(() {
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
