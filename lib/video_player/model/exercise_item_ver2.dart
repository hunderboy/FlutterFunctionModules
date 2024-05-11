import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseItemVer2 {
  late final int id;
  late final int count;
  late final int time;
  late final int level;
  late final String name;
  late final String description;
  late final String objectiveKr;
  late final String positionKr;
  late final String mediaUrl;
  late final String mediaThumbnailUrl;
  late final String imageThumbnailUrl;
  late List<String> tools;

  /// 변화되는 변수
  bool isComplete = false;
  double progress = 0.0;
  String remainingTimeText = "00:00";
  /// rx 변수
  RxBool rxIsComplete = false.obs;
  RxDouble rxProgress = 0.0.obs;
  RxString rxRemainingTimeText = "00:00".obs;

  setRunTime(){
    // todo Api에서 만들어서 넘겨달라고 해야함.
    var random = Random().nextInt(7);
    var time = selectTime(random);

    String runTime = "00:"+time.toString();
    remainingTimeText = runTime;
    rxRemainingTimeText.value = runTime;
  }
  int selectTime(int random) {
    switch (random) {
      case 0:
        return 35;
      case 1:
        return 45;
      case 2:
        return 58;
      case 3:
        return 46;
      case 4:
        return 40;
      case 5:
        return 52;
      case 6:
        return 39;
      default:
        return 32;
    }
  }
  setIsComplete(bool value) {
    isComplete = value;
    rxIsComplete.value = value;
  }

  ExerciseItemVer2({
    required this.id,
    required this.count,
    required this.time,
    required this.level,
    required this.name,
    required this.description,
    required this.objectiveKr,
    required this.positionKr,
    required this.mediaUrl,
    required this.mediaThumbnailUrl,
    required this.imageThumbnailUrl,
    required this.isComplete,
    required this.tools,
  })
  {
    setRunTime();
    setIsComplete(isComplete);
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'runTime': runTime,
  //     'title': title,
  //     'fileTitle': fileTitle,
  //     'isComplete': isComplete,
  //   };
  // }
  // factory ExerciseItem.fromJson(Map<String, dynamic> parsedJson) {
  //   return ExerciseItem(
  //     runTime : parsedJson['runTime'] as String,
  //     title : parsedJson['title'] as String,
  //     fileTitle : parsedJson['fileTitle'] as String,
  //     isComplete: parsedJson['isComplete'] as bool,
  //   );
  // }

}