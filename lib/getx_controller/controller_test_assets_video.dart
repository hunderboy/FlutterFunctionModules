import 'package:flutter_function_modules/model/exercise_item.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class ControllerTestAssetsVideo extends GetxController {

/// Player code ------------------------------------------------------------------------------------------------
  late VideoPlayerController playerController;
  late Future<void>? initializeVideoPlayerFuture;
  late int _playBackTime;
  RxBool isPlayingVideo = false.obs;

  var exerciseList = <ExerciseItem>[].obs;
  final _playingPosiotion = 0.obs;

  int videoPosition = 0;

  List<ExerciseItem> setTodayExercise() {
    List<ExerciseItem> todayExerciseProgram = <ExerciseItem>[]; // 초기화

    // 10개의 샘플 운동을 TodayExercisePlanList_1 에 추가한다.
    for (int i=0; i<7; i++) {
      switch(i) {
        case 0:
          ExerciseItem item = ExerciseItem(
              runTime : "00:06",
              title : "카운트다운",
              fileTitle : "countdown",// countdown
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
        case 1:
          ExerciseItem item = ExerciseItem(
              runTime : "00:35",
              title : "코브라 스트레칭",
              fileTitle : "sample_abdominal_stretching_cobra",// sample_abdominal_stretching_cobra
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
        case 2:
          ExerciseItem item = ExerciseItem(
              runTime : "00:46",
              title : "볼 스퀴즈",
              fileTitle : "sample_ball_squeeze",// sample_ball_squeeze
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
        case 3:
          ExerciseItem item = ExerciseItem(
              runTime : "00:32",
              title : "백 스탭",
              fileTitle : "sample_center_front_back_step", // sample_center_front_back_step
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
        case 4:
          ExerciseItem item = ExerciseItem(
              runTime : "00:41",
              title : "팔꿈치 플랭크",
              fileTitle : "sample_elbow_plank",// sample_elbow_plank
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
        case 5:
          ExerciseItem item = ExerciseItem(
              runTime : "00:30",
              title : "니 업 크런치 홀딩",
              fileTitle : "sample_kneeup_crunch_holding", // sample_knee_slide
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
        case 6:
          ExerciseItem item = ExerciseItem(
              runTime : "01:01",
              title : "슈퍼맨 익스텐션",
              fileTitle : "sample_superman_extension", // sample_kneeup_crunch_holding
              isComplete: false);
          todayExerciseProgram.add(item);
          break;
      }
    }

    return todayExerciseProgram;
  }


  @override
  void onInit() async{
    exerciseList.value = setTodayExercise();

    // playerController = VideoPlayerController.asset('assets/video/'+exerciseList[0].fileTitle+'.mp4');
    // playerController.addListener(() {
    //   _playBackTime = playerController.value.position.inSeconds;
    //   isPlayingVideo.value = playerController.value.isPlaying;
    //   print("isPlayingVideo : "+ isPlayingVideo.value.toString());
    // });
    // initializeVideoPlayerFuture = playerController.initialize().then((_) {
    //   playVideo();
    //   update();
    // });

    getValuesAndPlay(videoPosition,true);

  }
  @override
  void onClose() {
    print("ControllerTest - onClose()");
    initializeVideoPlayerFuture = null;
    playerController.pause().then((_) {
      playerController.dispose();
    });
    super.onClose();
  }

/// 비디오 플레이어 초기화 ------------------------------------------------------------------------------
  getValuesAndPlay(int idx, bool isInitializing) {
    if(isInitializing){
      _initializePlay(idx);
    }else{
      _startPlay(idx);
    }
  }
  Future<void> _startPlay(int idx) async {
    initializeVideoPlayerFuture = null;

    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        _initializePlay(idx);
      });
    });
  }
  Future<bool> _clearPrevious() async {
    await playerController.pause();
    return true;
  }
  /// VideoPlayer 초기화
  Future<void> _initializePlay(int idx) async {
    playerController = VideoPlayerController.asset('assets/video/'+exerciseList[idx].fileTitle+'.mp4');
    playerController.addListener(() {
      _playBackTime = playerController.value.position.inSeconds;
      // print("isPlayingVideo : "+ _playBackTime.toString());

      // if(playerController.value.position == playerController.value.duration ){
      //   print("position == duration");
      //   print(playerController.value.position);
      // }else if(playerController.value.position > playerController.value.duration){
      //   print("position > duration");
      //   print(playerController.value.position);
      // }

      // if(playerController.value.position == playerController.value.duration){
      //   if(videoPosition == 0){
      //     videoPosition++;
      //     getValuesAndPlay(1,false);
      //   }
      //   else if(videoPosition == 1){
      //     videoPosition++;
      //     getValuesAndPlay(2,false);
      //   }
      //   else{
      //
      //   }
      // }

    });
    initializeVideoPlayerFuture = playerController.initialize().then((_) {
      print("Total duration : "+playerController.value.duration.toString());
      playVideo();
      update();
    });
  }
/// ------------------------------------------------------------------------------------------------



  initVideoPlayerController(int index) async {
    playerController = VideoPlayerController.asset('assets/video/'+exerciseList[index].fileTitle+'.mp4');
    await playerController.initialize(); // 비디오 플레이어 초기화
    // _videoPlayerController1..initialize().then((_){});
    if(playerController.value.isInitialized){
      print("playerController 초기화 완료1");
    } else{
      print("playerController 초기화 완료 안됨.");
    }
  }


  setPlayerState() {
    if (playerController.value.isPlaying) {
      stopVideo();
    } else {
      playVideo();
    }
  }
  stopVideo(){
    // isPlayingVideo.value = false;
    playerController.pause();
  }
  playVideo(){
    // isPlayingVideo.value = true;
    playerController.play();
  }

}



// int count=0;
// // 단순 상태 업데이트
// void increment(){
//   count++;
//   update(); // 이 코드가 있어야 업데이트 됨.
// }