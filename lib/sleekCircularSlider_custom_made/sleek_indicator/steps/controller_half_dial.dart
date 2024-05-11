
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../package/src/appearance.dart';

class ControllerHalfDial extends GetxController {

  /// Custom
  var customWidth = CustomSliderWidths(trackWidth: 20, progressBarWidth: 20, shadowWidth: 10, handlerSize: 30);
  var customColors = CustomSliderColors(
    // dotColor: Colors.white.withOpacity(0.9),
    dotColor: Colors.white.withOpacity(1.0),
    trackColors: [Colors.grey.shade200, Colors.grey.shade200],
    // progressBarColors: [Colors.green, Colors.yellow, Colors.red,],
    progressBarColors: [ const Color(0xffD2F5F4),const Color(0xffD2F5F4),],
    gradientStartAngle: 0,
    gradientEndAngle: 330,
    // shadowColor: HexColor('#5FC7B0'),
    // shadowMaxOpacity: 0.05
  );
  late CircularSliderAppearance appearance;


  @override
  void onInit() {
    appearance = CircularSliderAppearance(
      customWidths: customWidth,
      customColors: customColors,
      animationEnabled: true,
      size: 250.0,
      startAngle: 180,
      angleRange: 180,
    );

    super.onInit();
  }

}