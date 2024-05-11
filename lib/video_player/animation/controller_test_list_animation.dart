import 'package:flutter/material.dart';
import 'package:flutter_function_modules/video_player/model/exercise_item.dart';
import 'package:get/get.dart';


class ControllerTestListAnimation extends GetxController with GetTickerProviderStateMixin {
  // var rxRemainingTimeText = "00:00".obs;
  bool visibility = true;
  late AnimationController animationController;
  var rxProgress = 0.0.obs;
  bool isStopping = true;

  /// 모든 운동 진행 데이터는 컨트롤러에서 관리
  var exerciseList = <ExerciseItem>[].obs;
  var _playingPosition = 0.obs;

  var animationProgressPoint = 0.0;
  ScrollController listScrollController = ScrollController();



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
  void onInit() {
    // 운동리스트를 싱글톤에 저장되어 있는 리스트와 일치시킨다.
    exerciseList.value = setTodayExercise();
    exerciseList[_playingPosition.value].rxProgress.value = 0.0;
    exerciseList[_playingPosition.value].rxRemainingTimeText.value = exerciseList[_playingPosition.value].runTime;

    /// Animation code ------------------------------------------------------------------------------------------------
    initAnimationController();
    print("status : "+animationController.status.toString());
    print("isAnimating : "+animationController.isAnimating.toString());


    animationController.addListener(() {

      exerciseList[_playingPosition.value].rxProgress.value = animationController.value; // 정방향 진행 : progress.value = (0.0 -> 1.0)
      exerciseList.refresh();

      if(animationController.isCompleted){
        animationProgressPoint = 0.0;
        exerciseList[_playingPosition.value].rxProgress.value = 0.0;
        _changeState(true);

        if(_playingPosition.value < 9){
          _playingPosition.value++;
          animationStart();
          animateToIndex(_playingPosition.value);
        }
        else if(_playingPosition.value == 9){
          _playingPosition.value = 0;
        }
      }
      // print("_playingPosition : "+_playingPosition.value.toString());
    });

    super.onInit();

  }
  @override
  void onClose() {
    print("ControllerTestListAnimation ---------------------------- onClose()");
    exerciseList[_playingPosition.value].rxProgress.value = 0.0;
    animationController.dispose();
    super.onClose();
  }
  initAnimationController(){
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    print("animationController 초기화 OK");
  }

  animationStart(){
    if(isStopping){
      _changeState(false);
      // animationController.forward(from: 0);
      animationController.forward(from: animationProgressPoint);
      visibility = false;
      update();
    }
  }
  _changeState(bool state){
    isStopping = state;
  }
  stop(){
    if(isStopping == false){
      print("animationController.value : "+animationController.value.toString());
      animationProgressPoint = animationController.value;
      animationController.stop();
      _changeState(true);
      visibility = true;
      update();
    }
  }



  animateToIndex(int index) {
    listScrollController.animateTo(
      index * 101, // 100(아이템의 높이) + 1(Divider 높이)
      duration: const Duration(seconds: 1),
      // curve: Curves.fastOutSlowIn,
      // curve: Curves.linear,
        curve: Curves.decelerate,

    );
  }

}