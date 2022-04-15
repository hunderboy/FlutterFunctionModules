part of circular_slider;

class _CurvePainter extends CustomPainter {
  final double angle;
  final CircularSliderAppearance appearance;
  final double startAngle;
  final double angleRange;
  final double value;   // angleToValue

  Offset? handler;
  Offset? center;
  late double radius;

  _CurvePainter({
    this.angle = 30,
    required this.appearance,
    required this.startAngle,
    required this.angleRange,
    required this.value,
  });

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);


  @override
  void paint(Canvas canvas, Size size) {
    radius = math.min(size.width / 2, size.height / 2) -
        appearance.progressBarWidth * 0.5;
    center = Offset(size.width / 2, size.height / 2);

    final progressBarRect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);

    Paint trackPaint;
    if (appearance.trackColors != null) {
      final trackGradient = SweepGradient(
        startAngle: degreeToRadians(appearance.trackGradientStartAngle),
        endAngle: degreeToRadians(appearance.trackGradientStopAngle),
        tileMode: TileMode.mirror,
        colors: appearance.trackColors!,
      );
      trackPaint = Paint()
        ..shader = trackGradient.createShader(progressBarRect)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = appearance.trackWidth;
    } else {
      trackPaint = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = appearance.trackWidth
        ..color = appearance.trackColor;
    }
    drawCircularArc(
        canvas: canvas,
        size: size,
        paint: trackPaint,
        ignoreAngle: true,
        spinnerMode: appearance.spinnerMode);

    if (!appearance.hideShadow) {
      drawShadow(canvas: canvas, size: size);
    }

    final currentAngle = appearance.counterClockwise ? -angle : angle;
    final dynamicGradient = appearance.dynamicGradient;
    final gradientRotationAngle = dynamicGradient
        ? appearance.counterClockwise
            ? startAngle + 10.0
            : startAngle - 10.0
        : 270.0;// 0 -> 270 으로 수정함
    final GradientRotation rotation =
        GradientRotation(degreeToRadians(gradientRotationAngle));

    final gradientStartAngle = dynamicGradient
        ? appearance.counterClockwise
            ? 360.0 - currentAngle.abs()
            : 0.0
        : appearance.gradientStartAngle;
    final gradientEndAngle = dynamicGradient
        ? appearance.counterClockwise
            ? 360.0
            : currentAngle.abs()
        : appearance.gradientStopAngle;
    final colors = dynamicGradient && appearance.counterClockwise
        ? appearance.progressBarColors.reversed.toList()
        : appearance.progressBarColors;
/// 기존 코드-------------------------------------------------------------------------------
//     final progressBarGradient = kIsWeb
//         ? LinearGradient(
//             tileMode: TileMode.mirror,
//             colors: colors,
//           )
//         : SweepGradient(
//             transform: rotation,
//             startAngle: degreeToRadians(gradientStartAngle),
//             endAngle: degreeToRadians(gradientEndAngle),
//             tileMode: TileMode.mirror,
//             colors: colors,
//           );

/// 수정 코드-------------------------------------------------------------------------------
/// StrokeCap.round 에 의한 circuler progressBar의 시작부분이 색상이 2개의 색상이 나눠져 보임으로 인해
/// 퀄리티가 떨어져 보임. 이를 해결하기 위해 코드 수정
/// 위의 주석 코드의 실행과 비교해보면 알수 있음

    // StrokeCap.round 을 쓴다는 가정하에 appearance.progressBarWidth 사용
    final double correction = math.atan(appearance.progressBarWidth / 2 / radius); // 새로 추가 부분

    final progressBarGradient = kIsWeb
        ? LinearGradient(
            tileMode: TileMode.mirror,
            colors: colors,
          )
        : SweepGradient(
            transform: GradientRotation(degreeToRadians(startAngle) - correction), // 수정부분
            startAngle: degreeToRadians(gradientStartAngle),
            endAngle: degreeToRadians(gradientEndAngle),
            tileMode: TileMode.mirror,
            colors: colors,
          );
/// -------------------------------------------------------------------------------

    final progressBarPaint = Paint()
    ..shader = progressBarGradient.createShader(progressBarRect)
      ..strokeCap = StrokeCap.round // StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = appearance.progressBarWidth;
    drawCircularArc(canvas: canvas, size: size, paint: progressBarPaint);

    /// DialDot 의 중앙 위치
    Offset handler = degreesToCoordinates(
        center!, -math.pi / 2 + startAngle + currentAngle + 1.5, radius);
    /// DialDot 그림자 그리는 부분
    Path oval = Path()
      ..addOval(Rect.fromCircle(center: handler, radius: appearance.handlerSize+2));
    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50);
    canvas.drawPath(oval, shadowPaint);
    /// DialDot 그리는 부분
    var dotPaint = Paint()
      ..color = appearance.dotColor;
    canvas.drawCircle(handler, appearance.handlerSize, dotPaint);

    /// DialDotText 그리는 부분
    drawDialDotText(
        canvas:canvas,
        letter:appearance.defaultPercentageModifier(value),
        dotCenterOffset: handler,
        type: "type_circle",
    );
  }// paint 함수 끝

  drawDialDotText({
    required Canvas canvas,
    required String letter,
    required Offset dotCenterOffset,  // dot 의 중심점 좌표
    required String type,
  }) {
    if(type == "type_circle"){
      TextStyle textStyle = const TextStyle(fontSize: 30, color: Colors.black);
      _textPainter.text = TextSpan(text: letter, style: textStyle);
      _textPainter.layout(
        minWidth: 0,
        maxWidth: double.maxFinite,
      );
      Offset textStartingPoint = Offset(
          dotCenterOffset.dx - (_textPainter.width*0.5),
          dotCenterOffset.dy - (_textPainter.height*0.5)
      );
      _textPainter.paint(canvas, textStartingPoint);
    }
    /// 걸음수 DialDot 이미지 설정 기능 구현 중단.
    else if(type == "type_half"){
      // canvas.drawImage(
      //     Image.clone
      //     dotCenterOffset,
      //     Paint()
      // );
    }

  }


  drawCircularArc(
      {required Canvas canvas,
      required Size size,
      required Paint paint,
      bool ignoreAngle = false,
      bool spinnerMode = false}) {
    final double angleValue = ignoreAngle ? 0 : (angleRange - angle);
    final range = appearance.counterClockwise ? -angleRange : angleRange;
    final currentAngle = appearance.counterClockwise ? angleValue : -angleValue;
    canvas.drawArc(
        Rect.fromCircle(center: center!, radius: radius),
        degreeToRadians(spinnerMode ? 0 : startAngle),
        degreeToRadians(spinnerMode ? 360 : range + currentAngle),
        false,
        paint);
  }

  drawShadow({required Canvas canvas, required Size size}) {
    final shadowStep = appearance.shadowStep != null
        ? appearance.shadowStep!
        : math.max(
            1, (appearance.shadowWidth - appearance.progressBarWidth) ~/ 10);
    final maxOpacity = math.min(1.0, appearance.shadowMaxOpacity);
    final repetitions = math.max(1,
        ((appearance.shadowWidth - appearance.progressBarWidth) ~/ shadowStep));
    final opacityStep = maxOpacity / repetitions;
    final shadowPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int i = 1; i <= repetitions; i++) {
      shadowPaint.strokeWidth = appearance.progressBarWidth + i * shadowStep;
      shadowPaint.color = appearance.shadowColor
          .withOpacity(maxOpacity - (opacityStep * (i - 1)));
      drawCircularArc(canvas: canvas, size: size, paint: shadowPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
