
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../package/sleek_circular_slider.dart';
import 'controller_half_dial.dart';


class CustomHalfDialIndicator extends GetView<ControllerHalfDial> {
  const CustomHalfDialIndicator({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerHalfDial());

    return Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(
                  margin: const EdgeInsets.all(10),
                  child: SleekCircularSlider(
                    // innerWidget: (double currentAngle) {
                    //   // use your custom widget inside the slider (gets a slider value from the callback)
                    //   return CustomInnerWidget(
                    //       currentAngle: currentAngle,
                    //       appearance: controller.appearance
                    //   );
                    // },
                    appearance: controller.appearance,
                    min: 1000,
                    max: 30000,
                    initialValue: 1500,
                    onChange: (double value) {
                      // callback providing a value while its being changed (with a pan gesture)
                      // print("값 : $value");
                    },
                  ),
                ),


              ]
          ),
        )
    );
  }

}
