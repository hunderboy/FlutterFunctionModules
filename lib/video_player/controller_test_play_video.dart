import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_function_modules/model/exercise_item.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';


class ControllerTestPlayVideo extends GetxController
    // with GetSingleTickerProviderStateMixin
    with SingleGetTickerProviderMixin
    // with GetTickerProviderStateMixin
    // with SingleTickerProviderStateMixin
{

/// Player code ------------------------------------------------------------------------------------------------
  late VideoPlayerController playerController;
  late Future<void>? initializeVideoPlayerFuture;
  RxBool isPlayingVideo = false.obs; // 비디오 플레이어 재생상태

/// Animation code ---------------------------------------------------------------------------------------------
  late AnimationController animationController;

  /// 카운트다운 시 남아 있는 시간 정보
  late int remainMinutes; // 분
  late int remainSeconds; // 초

  /// 모든 운동 진행 데이터는 컨트롤러에서 관리
  var exerciseList = <ExerciseItem>[].obs;
  var _playingPosition = 0.obs;
  int count = 0;

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
    // 운동리스트를 싱글톤에 저장되어 있는 리스트와 일치시킨다.
    exerciseList.value = setTodayExercise();
    // 운동중인 Position의 데이터 원상복귀 : 다시 운동플레이 화면으로 돌아오면 기존에 플레이하던 progress 값이 남아있는 문제 발생
    exerciseList[_playingPosition.value].rxProgress.value = 0.0;
    exerciseList[_playingPosition.value].rxRemainingTimeText.value = exerciseList[_playingPosition.value].runTime;


/// Player code ------------------------------------------------------------------------------------------------
    /// VideoPlayer 초기화
    playerController = VideoPlayerController.asset('assets/video/'+exerciseList[0].fileTitle+'.mp4');
    initializeVideoPlayerFuture = playerController.initialize().then((_) {
      initAnimationController();
      playVideo();
      // update();
    });

    // 컨트롤러 리스너 적용 : 재생중에는 계속 리스너 코드 내용이 반복 실행됨.
    playerController.addListener(() async {
      // exerciseList[_playingPosition.value].rxProgress.value = animationController.value; // 정방향 진행 : progress.value = (0.0 -> 1.0)
      // exerciseList.refresh();
      // print("value : "+exerciseList[_playingPosition.value].rxProgress.value.toString());
      isPlayingVideo.value = playerController.value.isPlaying;
      // increase();

      if(playerController.value.position == playerController.value.duration || playerController.value.position > playerController.value.duration) {
        print("재생 완료1");
        print("PlayerController : "+playerController.toString());
        // stopVideo();

        // 원상복귀
        exerciseList[_playingPosition.value].rxProgress.value = 0.0;
        exerciseList[_playingPosition.value].rxRemainingTimeText.value = exerciseList[_playingPosition.value].runTime;

        // 운동 완료 설정
        exerciseList[_playingPosition.value].isComplete = true;
        exerciseList[_playingPosition.value].rxIsComplete.value = true;
        exerciseList.refresh();
        await next();
        // _playingPosition.value = _playingPosition.value+1;
      }
      else{
        // print("비디오플레이어 재생중");
        remainMinutes = playerController.value.duration.inMinutes-playerController.value.position.inMinutes;
        remainSeconds = playerController.value.duration.inSeconds-playerController.value.position.inSeconds;
        // 카운트다운 텍스트 설정
        exerciseList[_playingPosition.value].rxRemainingTimeText.value = '${(remainMinutes % 60).toString().padLeft(2, '0')}:${(remainSeconds % 60).toString().padLeft(2, '0')}';

        exerciseList[_playingPosition.value].rxProgress.value = animationController.value; // 정방향 진행 : progress.value = (0.0 -> 1.0)
        exerciseList.refresh();
        print("value : "+exerciseList[_playingPosition.value].rxProgress.value.toString());
      }
    });


/// Animation code ------------------------------------------------------------------------------------------------
    initAnimationController();

    animationController.addListener(() {
      print("animationController 리스너 작동중");
      if (animationController.isAnimating) {
        print("애니메이팅 중");
        exerciseList[_playingPosition.value].rxProgress.value = 1-animationController.value; // 정방향 진행 : progress.value = (0.0 -> 1.0)
        exerciseList.refresh();
      }
    });

/// 기타 코드 작성 ------------------------------------------------------------------------------------------------
    // _playingPosition 변수가 변경 될때마다 호출된다.
    ever(_playingPosition, (_) async {
      await getValuesAndPlay(_playingPosition.value);
    });



    super.onInit();

    // const duration = Duration(seconds: 5);
    // animationController =
    //     AnimationController.unbounded(duration: duration, vsync: this);
    // animationController.repeat();
    // animationController.forward();
    // animationController.addListener(() =>
    //     print("Animation Controller value: ${animationController.value}")
    // );
  }
  @override
  void onClose() {
    print("ControllerTest - onClose()");
    initializeVideoPlayerFuture = null;
    playerController.pause().then((_) {
      playerController.dispose();
    });
    animationController.dispose();
    super.onClose();
  }


  /// ------------------------------------------------------------------------------------------------
  getValuesAndPlay(int idx) {
    _startPlay(idx);
  }

  Future<void> _startPlay(int idx) async {
    initializeVideoPlayerFuture = null;

    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        /// 인덱스 +1
        _initializePlay(idx);
      });
    });
  }

  Future<bool> _clearPrevious() async {
    await playerController.pause();
    return true;
  }

  Future<void> _initializePlay(int idx) async {
    playerController = VideoPlayerController.asset('assets/video/'+exerciseList[idx].fileTitle+'.mp4');
    playerController.addListener(() {
      // exerciseList[_playingPosition.value].rxProgress.value = animationController.value; // 정방향 진행 : progress.value = (0.0 -> 1.0)
      // exerciseList.refresh();
      // print("value : "+exerciseList[_playingPosition.value].rxProgress.value.toString());
      isPlayingVideo.value = playerController.value.isPlaying;
      // increase();

      if(playerController.value.position == playerController.value.duration || playerController.value.position > playerController.value.duration){
        print("재생 완료2");
        print("카운트 수2 : "+count.toString());
        print("PlayerController : "+playerController.toString());
        // stopVideo();
        // 원상복귀
        exerciseList[_playingPosition.value].rxProgress.value = 0.0;
        exerciseList[_playingPosition.value].rxRemainingTimeText.value = exerciseList[_playingPosition.value].runTime;
        // 운동 완료 설정
        exerciseList[_playingPosition.value].isComplete = true;
        exerciseList[_playingPosition.value].rxIsComplete.value = true;
        exerciseList.refresh();
      }
      else{
        // print("비디오플레이어 재생중");
        remainMinutes = playerController.value.duration.inMinutes-playerController.value.position.inMinutes;
        remainSeconds = playerController.value.duration.inSeconds-playerController.value.position.inSeconds;
        // 카운트다운 텍스트 설정
        exerciseList[_playingPosition.value].rxRemainingTimeText.value = '${(remainMinutes % 60).toString().padLeft(2, '0')}:${(remainSeconds % 60).toString().padLeft(2, '0')}';

        exerciseList[_playingPosition.value].rxProgress.value = animationController.value; // 정방향 진행 : progress.value = (0.0 -> 1.0)
        exerciseList.refresh();
        print("value : "+exerciseList[_playingPosition.value].rxProgress.value.toString());
      }
    });
    initializeVideoPlayerFuture = playerController.initialize().then((_) {
      initAnimationController();
      playVideo();
      update();
    });
  }
  /// ------------------------------------------------------------------------------------------------



  initAnimationController(){
    animationController = AnimationController(vsync: this, duration: playerController.value.duration);
    print("animationController 초기화 OK");
  }
  void setPlayerState() {
    if (playerController.value.isPlaying) {
      stopVideo();
    } else {
      playVideo();
    }
  }
  stopVideo(){
    playerController.pause();
    animationController.stop();
  }
  playVideo(){
    playerController.play();
    animationController.forward();
    // animationController.reverse(  // 애니메이션 재생
    //     from: animationController.value == 0 ? 1.0 : animationController.value);
  }



  increase(){
    count++;
  }

  next() async {
    Future.microtask(() {
      _playingPosition.value = _playingPosition.value + 1;
    });
  }



  // initVideoPlayerController(int index) async {
  //   playerController = VideoPlayerController.asset('assets/video/'+exerciseList[index].fileTitle+'.mp4');
  //   await playerController.initialize(); // 비디오 플레이어 초기화
  //   // _videoPlayerController1..initialize().then((_){});
  //
  //   if(playerController.value.isInitialized){
  //     print("playerController 초기화 완료1");
  //   } else{
  //     print("playerController 초기화 완료 안됨.");
  //   }
  // }

}




// 끝나는 타이밍에 소리내는 알람을 울린다.
// void notify() {
//   print("countText == 00:00");
//   FlutterRingtonePlayer.playNotification(); // '띵' 하는 소리 울림
//   isPlayingVideo.value = false; // 플레잉 중지
//   progress.value = 0.0;         // 100% 다 채워지게 한다.
//   playerController.pause();
// }