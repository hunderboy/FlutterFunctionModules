import 'package:flutter/material.dart';
import 'appearance.dart';

/// 기본 inner 위젯
class SliderLabel extends StatelessWidget {
  final double value;
  final CircularSliderAppearance appearance;
  const SliderLabel({Key? key, required this.value, required this.appearance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: builtInfo(appearance),
    );
  }

  List<Widget> builtInfo(CircularSliderAppearance appearance) {
    var widgets = <Widget>[];
    if (appearance.infoTopLabelText != null) {
      widgets.add(Text(
        appearance.infoTopLabelText!,
        style: appearance.infoTopLabelStyle,
      ));
    }
    final modifier = appearance.infoModifier(value);
    widgets.add(
      Text('$modifier', style: appearance.infoMainLabelStyle),
    );
    if (appearance.infoBottomLabelText != null) {
      widgets.add(Text(
        appearance.infoBottomLabelText!,
        style: appearance.infoBottomLabelStyle,
      ));
    }
    return widgets;
  }
}
