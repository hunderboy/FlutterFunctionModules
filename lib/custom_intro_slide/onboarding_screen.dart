import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_function_modules/common/const/colors.dart';
import 'package:flutter_function_modules/custom_intro_slide/intro_slider.dart';
import 'package:flutter_function_modules/custom_intro_slide/slide_object.dart';



class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key,}) : super(key: key);
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  final TextStyle onBoardTextStyle = const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: QuickaColor.Grey_100,
      letterSpacing: -0.3,
      height: 1.5
  );

  /// 각 Slide 데이터 설정
  List<Slide> slides = [];
  @override
  void initState() {
    super.initState();

    // 슬라이드 0 ---------------------------------------------------------------------
    slides.add(
      Slide(
        title: "저장 버튼 한 번만 누르세요.\n카테고리 분류는 퀵카이브가 알아서!",
        styleTitle: onBoardTextStyle,
        // pathImage: "assets/onboarding_test_img/intro_1.png",
        pathImage: "assets/onboarding_test_img/onboard_1.png",
      ),
    );
    // 슬라이드 1 ---------------------------------------------------------------------
    slides.add(
      Slide(
        title: "PC, 모바일 어디 기기에서든\n퀵카이브를 사용할 수 있어요.",
        styleTitle: onBoardTextStyle,
        // pathImage: "assets/onboarding_test_img/intro_2.png",
        pathImage: "assets/onboarding_test_img/onboard_2.png",
      ),
    );
    // 슬라이드 2 ---------------------------------------------------------------------
    slides.add(
      Slide(
        title: "모아둔 콘텐츠가 나의 자산이\n되는 걸 느껴보세요.",
        styleTitle: onBoardTextStyle,
        // pathImage: "assets/onboarding_test_img/intro_3.png",
        pathImage: "assets/onboarding_test_img/onboard_3.png",
      ),
    );
  }


  /// Slide 데이터를 가지고 페이지 렌더링
  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];

    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];

      tabs.add(
        /// 기존 코드
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// 타이틀 텍스트
            Text(
                currentSlide.title ?? "title 이 비어있음",
                style: currentSlide.styleTitle,
                textAlign: TextAlign.center
            ),
            const SizedBox(height: 20,),
            /// 이미지
            Expanded(
              child:
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.bottomCenter, // 하단 중앙에서 시작하도록 수정
                    end: Alignment.center,
                    colors: [
                      Colors.white.withOpacity(0.02),
                      Colors.white,
                    ],
                    stops: const [0, 0.4], // stop을 조정하여 그라데이션의 범위를 조절할 수 있습니다.
                    tileMode: TileMode.clamp,
                  ).createShader(bounds);
                },
                child: Container(
                  // color: Colors.amber,
                    child: i == 2
                        ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            currentSlide.pathImage ?? "assets/onboarding_test_img/intro_image_1.png",
                            fit: BoxFit.cover,
                            alignment: Alignment.topLeft,
                          ),
                        )
                        : Image.asset(
                          currentSlide.pathImage ?? "assets/onboarding_test_img/intro_image_1.png",
                          fit: BoxFit.scaleDown,
                        )
                )
              )
            )
          ],
        ),
      );
    }

    return tabs;
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,   // ios 상태바 텍스트 컬러 = black
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: IntroSlider(
                  // Dot indicator
                  colorActiveDot: QuickaColor.Grey_100,
                  colorDot: QuickaColor.Grey_20,
                  sizeDot: 5,
                  typeDotAnimation: dotSliderAnimation.NOTHING, // DOT_MOVEMENT
                  dotPositionTop: true,
                  // Tabs
                  listCustomTabs: renderListCustomTabs(),
                  // Behavior
                  scrollPhysics: const BouncingScrollPhysics(),
                  /// skipButton
                  showSkipBtn: false,
                  /// nextButton
                  showNextBtn: true,
                )
            )
        )
    );
  }

}