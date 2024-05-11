// import 'dart:math' as math;
// num radians(num deg) => deg * (math.pi / 180.0);
import 'package:flutter/material.dart';
import 'package:flutter_function_modules/sleekCircularSlider_custom_made/sleek_indicator/package/src/appearance.dart';
import 'package:get/get.dart';


class ControllerSleek extends GetxController {

  /// Custom
  var customWidth = CustomSliderWidths(trackWidth: 22, progressBarWidth: 20, shadowWidth: 10, handlerSize: 30);
  var customColors = CustomSliderColors(
    // dotColor: Colors.white.withOpacity(0.9),
    dotColor: Colors.white.withOpacity(1.0),
    trackColors: [Colors.grey.shade300, Colors.grey.shade300],
    // progressBarColors: [Colors.green, Colors.yellow, Colors.red,],
    progressBarColors: [ const Color(0xff94D185), const Color(0xffFDFF8D), const Color(0xffF17676)],
    gradientStartAngle: 0,
    gradientEndAngle: 330,
    // shadowColor: HexColor('#5FC7B0'),
    // shadowMaxOpacity: 0.05
  );
  late CircularSliderAppearance appearance;



/// 실험 코드 ------------------------------------------------------------------------------
  /// Timer Example
  // var customWidth01 = CustomSliderWidths(trackWidth: 5, progressBarWidth: 20, shadowWidth: 0);
  // var customColors01 = CustomSliderColors(
  //   dotColor: Colors.white.withOpacity(0.8),
  //   trackColor: HexColor('#FFD4BE').withOpacity(0.4),
  //   progressBarColor: HexColor('#F6A881'),
  //   shadowColor: HexColor('#FFD4BE'),
  //   shadowStep: 10.0,
  //   shadowMaxOpacity: 0.6
  // );
  // late CircularSliderAppearance appearance01;
  //
  // /// Example 03
  // var customWidth03 = CustomSliderWidths(trackWidth: 22, progressBarWidth: 20, shadowWidth: 10);
  // var customColors03 = CustomSliderColors(
  //     trackColors: [Colors.grey.shade300, Colors.grey.shade300],
  //     progressBarColors: [Colors.green, Colors.yellow, Colors.red,],
  //     shadowColor: HexColor('#5FC7B0'),
  //     dynamicGradient: true,
  //     shadowMaxOpacity: 0.05);
  //
  // var info03 = InfoProperties(
  //     bottomLabelStyle: TextStyle(
  //         color: HexColor('#002D43'), fontSize: 20, fontWeight: FontWeight.w700),
  //     bottomLabelText: 'Goal',
  //     mainLabelStyle: TextStyle(
  //         color: Color.fromRGBO(97, 169, 210, 1),
  //         fontSize: 30.0,
  //         fontWeight: FontWeight.w200),
  //     modifier: (double value) {
  //       final kcal = value.toInt();
  //       return '$kcal kCal';
  //     });
  // late CircularSliderAppearance appearance03;



  @override
  void onInit() {
    appearance = CircularSliderAppearance(
      customWidths: customWidth,
      customColors: customColors,
      animationEnabled: true,
      size: 250.0,
      startAngle: 270,
      angleRange: 360,
    );

/// 실험 코드 ------------------------------------------------------------------------------
    // appearance01 = CircularSliderAppearance(
    //     customWidths: customWidth01,
    //     customColors: customColors01,
    //     startAngle: 270,
    //     angleRange: 360,
    //     size: 200.0,
    //     animationEnabled: false
    // );
    // appearance03 = CircularSliderAppearance(
    //     customWidths: customWidth03,
    //     customColors: customColors03,
    //     infoProperties: info03,
    //     size: 200.0,
    //     startAngle: 180,
    //     angleRange: 340);


    super.onInit();
  }



}

