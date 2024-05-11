import 'package:flutter/material.dart';
import '../package/src/appearance.dart';


class CustomInnerWidget extends StatelessWidget {
  const CustomInnerWidget({Key? key, required this.currentAngle, required this.appearance,}) : super(key: key);
  final double currentAngle;
  final CircularSliderAppearance appearance;

  @override
  Widget build(BuildContext context) {
    // final modifier = appearance.infoModifier(value);
    print("CustomInnerWidget : $currentAngle");

    return Center(
        child: Container(
          child: faceByPainLevel()
        ),
    );
  }

  Widget faceByPainLevel() {

    if(currentAngle >= 0.0 && currentAngle <= 18.0){
      return Image.asset('assets/image/pain_level_face/stage_0.png'); // value : 0
    }
    else if(currentAngle > 18.0 && currentAngle <= 54.0){
      return Image.asset('assets/image/pain_level_face/stage_1to2.png'); // value : 1
    }
    else if(currentAngle > 54.0 && currentAngle <= 90.0){
      return Image.asset('assets/image/pain_level_face/stage_1to2.png'); // value : 2
    }
    else if(currentAngle > 90.0 && currentAngle <= 126.0){
      return Image.asset('assets/image/pain_level_face/stage_3to4.png'); // value : 3
    }
    else if(currentAngle > 126.0 && currentAngle <= 162.0){
      return Image.asset('assets/image/pain_level_face/stage_3to4.png'); // value : 4
    }
    else if(currentAngle > 162.0 && currentAngle <= 198.0){
      return Image.asset('assets/image/pain_level_face/stage_5to6.png'); // value : 5
    }
    else if(currentAngle > 198.0 && currentAngle <= 234.0){
      return Image.asset('assets/image/pain_level_face/stage_5to6.png'); // value : 6
    }
    else if(currentAngle > 234.0 && currentAngle <= 270.0){
      return Image.asset('assets/image/pain_level_face/stage_7to8.png'); // value : 7
    }
    else if(currentAngle > 270.0 && currentAngle <= 306.0){
      return Image.asset('assets/image/pain_level_face/stage_7to8.png'); // value : 8
    }
    else if(currentAngle > 306.0 && currentAngle <= 342.0){
      return Image.asset('assets/image/pain_level_face/stage_9to10.png'); // value : 9
    }
    else if(currentAngle > 342.0 && currentAngle <= 360.0){
      return Image.asset('assets/image/pain_level_face/stage_9to10.png'); // value : 10
    }
    else{
      return Image.asset('assets/image/pain_level_face/stage_0.png'); // default value : 0
    }


  }



}