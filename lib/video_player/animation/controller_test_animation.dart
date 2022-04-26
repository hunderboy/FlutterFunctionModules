import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ControllerTestAnimation extends GetxController
    // with GetSingleTickerProviderStateMixin
    // with SingleGetTickerProviderMixin
    with GetTickerProviderStateMixin
    // with SingleTickerProviderStateMixin
{
  // var rxRemainingTimeText = "00:00".obs;
  late AnimationController animationController;
  var rxProgress = 0.0.obs;
  bool isActive = true;

  @override
  void onInit() {
    /// Animation code ------------------------------------------------------------------------------------------------
    initAnimationController();
    print("status : "+animationController.status.toString());
    print("isAnimating : "+animationController.isAnimating.toString());


    animationController.addListener(() {
      // print("애니메이션 컨트롤러 status : "+animationController.status.toString());
      // print("animationController.isAnimating : "+animationController.isAnimating.toString());
      rxProgress.value = animationController.value; // 정방향 진행 : progress.value = (0.0 -> 1.0)

      if(animationController.isCompleted){
        rxProgress.value = 0.0;
        _changeState(true);
      }

    });

    super.onInit();

  }
  @override
  void onClose() {
    print("ControllerTest - onClose()");
    animationController.dispose();
    super.onClose();
  }
  initAnimationController(){
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    print("animationController 초기화 OK");
  }

  animationStart(){
    if(isActive){
      _changeState(false);
      animationController.forward(from: 0);
    }
  }
  _changeState(bool state){
    isActive = state;
  }

}