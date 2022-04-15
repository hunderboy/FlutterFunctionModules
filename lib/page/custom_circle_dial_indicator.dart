import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_function_modules/custom_widgets/sleek_indicator/package/sleek_circular_slider.dart';
import 'package:flutter_function_modules/custom_widgets/sleek_indicator/pain/custom_inner_widget.dart';
import 'package:flutter_function_modules/getx_controller/controller_sleek.dart';



class CustomCircleDialIndicator extends GetView<ControllerSleek> {
  const CustomCircleDialIndicator({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerSleek());

    return Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(
                  margin: const EdgeInsets.all(10),
                  child:
                  SleekCircularSlider(
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


              ]
          ),
        )
    );
  }

}