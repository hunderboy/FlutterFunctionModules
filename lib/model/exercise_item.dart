

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseItem {
  late final String runTime;  // 영상의 총길이는 현재 long 타입으로 넘어온다고 한다. 총길이가 int 한도 범위를 넘어갈것으로 보이지는 않음.
  late final String title;
  late final String fileTitle; // [영상 : fileTitle + .mp4] [썸네일 : fileTitle + .png]

  /// 변화되는 변수
  bool isComplete = false;
  RxBool rxIsComplete = false.obs;
  double progress = 0.0;
  RxDouble rxProgress = 0.0.obs;
  String remainingTimeText = "00:00";
  RxString rxRemainingTimeText = "00:00".obs;

  setRunTime(String value){
    // runTime = "00:"+value.toString();
    remainingTimeText = value;
    rxRemainingTimeText.value = value;
  }
  setIsComplete(bool value) {
    // isComplete = value;

    rxIsComplete.value = value;
  }

  ExerciseItem({
    required this.runTime,
    required this.title,
    required this.fileTitle,
    required this.isComplete,
  })
  {
    setRunTime(runTime);
    setIsComplete(isComplete);
  }

  Map<String, dynamic> toJson() {
    return {
      'runTime': runTime,
      'title': title,
      'fileTitle': fileTitle,
      'isComplete': isComplete,
    };
  }
  factory ExerciseItem.fromJson(Map<String, dynamic> parsedJson) {
    return ExerciseItem(
      runTime : parsedJson['runTime'] as String,
      title : parsedJson['title'] as String,
      fileTitle : parsedJson['fileTitle'] as String,
      isComplete: parsedJson['isComplete'] as bool,
    );
  }

}