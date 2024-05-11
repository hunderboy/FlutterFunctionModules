import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_function_modules/sleekCircularSlider_custom_made/sleek_indicator/package/src/circular_slider.dart';
import 'package:flutter_function_modules/sleekCircularSlider_custom_made/sleek_indicator/pain/custom_inner_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_function_modules/sleekCircularSlider_custom_made/controller_sleek.dart';



class CustomCircleDialIndicator extends GetView<ControllerSleek> {
  const CustomCircleDialIndicator({Key? key,}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Get.put(ControllerSleek());


    /// 상태바 설정 방식
    const statusBarTextType = SystemUiOverlayStyle(
      /// ios
      // statusBarBrightness: Brightness.dark, // ios 상태바 텍스트 컬러 = white
        statusBarBrightness: Brightness.light,   // ios 상태바 텍스트 컬러 = black
        /// android
        statusBarIconBrightness: Brightness.light,// Android 텍스트 컬러
        statusBarColor: Colors.red  // Android 백그라운드 컬러
    );


    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('CustomCircleDialIndicator'),
      //   /// AppBar 가 있을때 상태바 처리
      //   systemOverlayStyle: statusBarTextType,
      // ),
      appBar: AppBar(
        /// AppBar 가 있을때 상태바 처리
        systemOverlayStyle: statusBarTextType,
        title: const Text(
            'CustomCircleDialIndicator',
          style: TextStyle(
            color: Color(0xff000000)
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, size: 24, color: Color(0xff000000)),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: SleekCircularSlider(
            innerWidget: (double currentAngle) {
              // use your custom widget inside the slider (gets a slider value from the callback)
              return CustomInnerWidget(
                  currentAngle: currentAngle,
                  appearance: controller.appearance
              );
            },
            appearance: controller.appearance,
            min: 0,
            max: 10,
            initialValue: 0,
            // callback providing a value while its being changed (with a pan gesture)
            onChange: (double value) {},
            // callback providing a starting value (when a pan gesture starts)
            onChangeStart: (double startValue) {},
            // callback providing an ending value (when a pan gesture ends)
            onChangeEnd: (double endValue) {},
          ),
        ),
      )
    );
  }

}