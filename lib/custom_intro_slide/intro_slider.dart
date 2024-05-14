// ignore_for_file: camel_case_types, constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_function_modules/common/const/colors.dart';


import 'slide_object.dart';


// list_rtl_language
const List<String> rtlLanguages = <String>[
  'ar', // Arabic
  'fa', // Farsi
  'he', // Hebrew
  'ps', // Pashto
  'ur', // Urdu
];

// Type dots animation
enum dotSliderAnimation {
  SIZE_TRANSITION,  // 사이즈 변화
  DOT_MOVEMENT,     // dot 이동
  NOTHING           // 애니메이션 효과 없음
}

// Scrollbar behavior values
enum scrollbarBehavior { HIDE, SHOW, SHOW_ALWAYS }






class IntroSlider extends StatefulWidget {
  // ---------- Slides ----------
  /// An array of Slide object
  final List<Slide>? slides;

  /// Background color for all slides
  final Color? backgroundColorAllSlides;

  // ---------- SKIP button ----------
  /// Render your own widget SKIP button
  final Widget? renderSkipBtn;

  /// Render your own style SKIP button
  final ButtonStyle? skipButtonStyle;

  /// Fire when press SKIP button
  final void Function()? onSkipPress;

  /// Show or hide SKIP button
  final bool? showSkipBtn;

  /// Assign Key to SKIP button
  final Key? skipButtonKey;

  // ---------- PREV button ----------
  /// Render your own widget PREV button
  final Widget? renderPrevBtn;

  /// Render your own style PREV button
  final ButtonStyle? prevButtonStyle;

  /// Show or hide PREV button (only visible if skip is hidden)
  final bool? showPrevBtn;

  /// Assign Key to PREV button
  final Key? prevButtonKey;

  // ---------- NEXT button ----------
  /// Render your own widget NEXT button
  final Widget? renderNextBtn;

  /// Render your own style NEXT button
  final ButtonStyle? nextButtonStyle;

  /// Show or hide NEXT button
  final bool? showNextBtn;

  /// Assign Key to NEXT button
  final Key? nextButtonKey;

  // ---------- DONE button ----------
  /// Render your own widget DONE button
  final Widget? renderDoneBtn;

  /// Render your own style NEXT button
  final ButtonStyle? doneButtonStyle;

  /// Fire when press DONE button
  final void Function()? onDonePress;

  /// Show or hide DONE button
  final bool? showDoneBtn;

  /// Assign Key to DONE button
  final Key? doneButtonKey;

  // ---------- Dot indicator ----------
  /// Show or hide dot indicator
  final bool? showDotIndicator;

  /// Color for dot when passive
  final Color? colorDot;

  /// Color for dot when active
  final Color? colorActiveDot;

  /// Size of each dot
  final double? sizeDot;

  /// Type dots animation
  final dotSliderAnimation? typeDotAnimation;

  /// Dot Position : Dot 포지션 (내가 새로 만듬)
  final bool? dotPositionTop; // default : false , true 시 슬라이드 상단에 위치

  // ---------- Tabs ----------
  /// Render your own custom tabs
  final List<Widget>? listCustomTabs;

  /// Notify when tab change completed
  final void Function(int index)? onTabChangeCompleted;

  /// Ref function go to specific tab index
  final void Function(Function function)? refFuncGoToTab;

  // ---------- Behavior ----------
  /// Whether or not the slider is scrollable (or controlled only by buttons)
  final bool? isScrollable;
  final ScrollPhysics? scrollPhysics;

  /// Show or hide status bar
  final bool? hideStatusBar;

  /// The way the vertical scrollbar should behave
  final scrollbarBehavior? verticalScrollbarBehavior;

  // Constructor
  IntroSlider({
    // Slides
    this.slides,
    this.backgroundColorAllSlides,

    // Skip
    this.renderSkipBtn,
    this.skipButtonStyle,
    this.onSkipPress,
    this.showSkipBtn,
    this.skipButtonKey,

    // Prev
    this.renderPrevBtn,
    this.prevButtonStyle,
    this.showPrevBtn,
    this.prevButtonKey,

    // Done
    this.renderDoneBtn,
    this.onDonePress,
    this.doneButtonStyle,
    this.showDoneBtn,
    this.doneButtonKey,

    // Next
    this.renderNextBtn,
    this.nextButtonStyle,
    this.showNextBtn,
    this.nextButtonKey,

    // Dots
    this.colorActiveDot,
    this.colorDot,
    this.showDotIndicator,
    this.sizeDot,
    this.typeDotAnimation,
    this.dotPositionTop,

    // Tabs
    this.listCustomTabs,
    this.onTabChangeCompleted,
    this.refFuncGoToTab,

    // Behavior
    this.isScrollable,
    this.scrollPhysics,
    this.hideStatusBar,
    this.verticalScrollbarBehavior,
  });

  @override
  IntroSliderState createState() => IntroSliderState();
}

class IntroSliderState extends State<IntroSlider> with TickerProviderStateMixin {

  // ---------- Slides ----------
  /// An array of Slide object
  late final List<Slide>? slides;

  // ---------- SKIP button ----------
  /// Render your own widget SKIP button
  late final Widget renderSkipBtn;

  /// Fire when press SKIP button
  late final void Function()? onSkipPress;

  /// Render your own style SKIP button
  late final ButtonStyle skipButtonStyle;

  /// Show or hide SKIP button
  late final bool showSkipBtn;

  /// Assign Key to SKIP button
  late final Key? skipButtonKey;

  // ---------- PREV button ----------
  /// Render your own widget PREV button
  late final Widget renderPrevBtn;

  /// Render your own style PREV button
  late final ButtonStyle prevButtonStyle;

  /// Show or hide PREV button
  late final bool showPrevBtn;

  /// Assign Key to PREV button
  late final Key? prevButtonKey;

  // ---------- DONE button ----------
  /// Render your own widget DONE button
  late final Widget renderDoneBtn;

  /// Fire when press DONE button
  late final void Function()? onDonePress;

  /// Render your own style DONE button
  late final ButtonStyle doneButtonStyle;

  /// Show or hide DONE button
  late final bool showDoneBtn;

  /// Assign Key to DONE button
  late final Key? doneButtonKey;

  // ---------- NEXT button ----------
  /// Render your own widget NEXT button
  late final Widget renderNextBtn;

  /// Render your own style NEXT button
  late final ButtonStyle nextButtonStyle;

  /// Show or hide NEXT button
  late final bool showNextBtn;

  /// Assign Key to NEXT button
  late final Key? nextButtonKey;

  // ---------- Dot indicator ----------
  /// Show or hide dot indicator
  late final bool showDotIndicator;

  /// Color for dot when passive
  late final Color colorDot;

  /// Color for dot when active
  late final Color colorActiveDot;

  /// Size of each dot
  late final double sizeDot;

  /// 닷포지션
  late final bool dotPositionTop;


  /// Type dots animation
  late final dotSliderAnimation typeDotAnimation;

  late double dotIndicatorOpacity = 1.0;

  // ---------- Tabs ----------
  /// List custom tabs
  List<Widget>? listCustomTabs;

  /// Notify when tab change completed
  Function? onTabChangeCompleted;

  // ---------- Behavior ----------
  /// Allow the slider to scroll
  late final bool isScrollable;
  late final ScrollPhysics scrollPhysics;

  /// The way the vertical scrollbar should behave
  late final scrollbarBehavior verticalScrollbarBehavior;

  late TabController tabController;
  late AnimationController animationController;

  List<Widget> tabs = [];
  List<Widget> dots = [];
  List<double> sizeDots = [];
  List<double> opacityDots = [];
  List<ScrollController> scrollControllers = [];

  /// stream
  // final streamDecoIndicator = StreamController<TripIndicatorDecoration>();
  // final streamMarginIndicatorFocusing = StreamController<PairIndicatorMargin>();
  final streamCurrentTabIndex = StreamController<int>.broadcast();

  /// For DOT_MOVEMENT
  double marginLeftDotFocused = 0;
  double marginRightDotFocused = 0;

  /// For SIZE_TRANSITION
  double currentAnimationValue = 0;
  int currentTabIndex = 0;

  /// For NOTHING
  double nothingMarginLeft = 0;
  double nothingMarginRight = 0;

  late final int lengthSlide;

  @override
  void initState() {
    super.initState();
    slides = widget.slides;

    skipButtonKey = widget.skipButtonKey;
    prevButtonKey = widget.prevButtonKey;
    doneButtonKey = widget.doneButtonKey;
    nextButtonKey = widget.nextButtonKey;

    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animationController.forward();

    lengthSlide = slides?.length ?? widget.listCustomTabs?.length ?? 0;

    streamCurrentTabIndex.add(0);
    onTabChangeCompleted = widget.onTabChangeCompleted;
    tabController = TabController(length: lengthSlide, vsync: this);

    // Send reference function goToTab to parent
    widget.refFuncGoToTab?.call(goToTab);

    // Dot animation
    sizeDot = widget.sizeDot ?? 8.0;
    // 초기 dot 마진
    final initValueMarginRight = (sizeDot * 2) * (lengthSlide - 1);

    typeDotAnimation = widget.typeDotAnimation ?? dotSliderAnimation.DOT_MOVEMENT;

    tabController.addListener(() {
      print("tabController : "+tabController.index.toString());
      nothingMarginLeft = tabController.index * sizeDot * 2;
      nothingMarginRight = initValueMarginRight - tabController.index * sizeDot * 2;


      if (tabController.indexIsChanging) {
        currentTabIndex = tabController.previousIndex;
      } else {
        currentTabIndex = tabController.index;
        streamCurrentTabIndex.add(currentTabIndex);
        onTabChangeCompleted?.call(tabController.index);
      }
      currentAnimationValue = tabController.animation?.value ?? 0;
    });


    switch (typeDotAnimation) {
      case dotSliderAnimation.DOT_MOVEMENT:
        for (var i = 0; i < lengthSlide; i++) {
          sizeDots.add(sizeDot);
          opacityDots.add(1.0);
        }
        marginRightDotFocused = initValueMarginRight; // 초기 마진 설정
        break;
      case dotSliderAnimation.SIZE_TRANSITION:
        for (var i = 0; i < lengthSlide; i++) {
          if (i == 0) {
            sizeDots.add(sizeDot * 1.5);
            opacityDots.add(1.0);
          } else {
            sizeDots.add(sizeDot);
            opacityDots.add(0.5);
          }
        }
        break;
      /// 애니메이션 효과 없음 경우
      case dotSliderAnimation.NOTHING:
        for (var i = 0; i < lengthSlide; i++) {
          sizeDots.add(sizeDot);
          opacityDots.add(1.0);
        }
        nothingMarginRight = initValueMarginRight; // 초기 마진 설정
    }

    tabController.animation?.addListener(() {
      setState(() {
        switch (typeDotAnimation) {
          case dotSliderAnimation.DOT_MOVEMENT:
            marginLeftDotFocused = tabController.animation!.value * sizeDot * 2;
            marginRightDotFocused = initValueMarginRight - tabController.animation!.value * sizeDot * 2;

            /// 마지막 페이지 이동중에 dot 투명도 fade out 처리
            var tabSize = initValueMarginRight / (lengthSlide - 1);
            if (marginRightDotFocused < tabSize) {
              dotIndicatorOpacity = marginRightDotFocused / tabSize;
            } else {
              dotIndicatorOpacity = 1;
            }
            break;

          case dotSliderAnimation.SIZE_TRANSITION:
            if (tabController.animation!.value == currentAnimationValue) {
              break;
            }

            var diffValueAnimation =
                (tabController.animation!.value - currentAnimationValue).abs();
            final diffValueIndex =
                (currentTabIndex - tabController.index).abs();

            // When press skip button
            if (tabController.indexIsChanging &&
                (tabController.index - tabController.previousIndex).abs() > 1) {
              if (diffValueAnimation < 1.0) {
                diffValueAnimation = 1.0;
              }
              sizeDots[currentTabIndex] = sizeDot * 1.5 -
                  (sizeDot / 2) * (1 - (diffValueIndex - diffValueAnimation));
              sizeDots[tabController.index] = sizeDot +
                  (sizeDot / 2) * (1 - (diffValueIndex - diffValueAnimation));
              opacityDots[currentTabIndex] =
                  1.0 - (diffValueAnimation / diffValueIndex) / 2;
              opacityDots[tabController.index] =
                  0.5 + (diffValueAnimation / diffValueIndex) / 2;
            } else {
              if (tabController.animation!.value > currentAnimationValue) {
                // Swipe left
                sizeDots[currentTabIndex] =
                    sizeDot * 1.5 - (sizeDot / 2) * diffValueAnimation;
                sizeDots[currentTabIndex + 1] =
                    sizeDot + (sizeDot / 2) * diffValueAnimation;
                opacityDots[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityDots[currentTabIndex + 1] = 0.5 + diffValueAnimation / 2;
              } else {
                // Swipe right
                sizeDots[currentTabIndex] =
                    sizeDot * 1.5 - (sizeDot / 2) * diffValueAnimation;
                sizeDots[currentTabIndex - 1] =
                    sizeDot + (sizeDot / 2) * diffValueAnimation;
                opacityDots[currentTabIndex] = 1.0 - diffValueAnimation / 2;
                opacityDots[currentTabIndex - 1] = 0.5 + diffValueAnimation / 2;
              }
            }
            break;

          case dotSliderAnimation.NOTHING:
            /// marginLeftDotFocused , marginRightDotFocused 는 dot fade out 처리에 영향을 주기 때문에
            /// tabController.animation?.addListener 에 있어야 한다.
            // marginLeftDotFocused = tabController.animation!.value * sizeDot * 2;
            // marginRightDotFocused = initValueMarginRight - tabController.animation!.value * sizeDot * 2;
            // /// 마지막 페이지 이동중에 dot fade out 처리
            // var tabSize = initValueMarginRight / (lengthSlide - 1);
            // if (marginRightDotFocused < tabSize) {
            //   dotIndicatorOpacity = marginRightDotFocused / tabSize;
            // } else {
            //   dotIndicatorOpacity = 1;
            // }
            // break;
        }
      });
    });

    // Dot indicator
    showDotIndicator = widget.showDotIndicator ?? true;

    dotPositionTop = widget.dotPositionTop ?? false;

    colorDot = widget.colorDot ?? const Color(0x80000000);

    colorActiveDot = widget.colorActiveDot ?? colorDot;

    isScrollable = widget.isScrollable ?? true;

    scrollPhysics = widget.scrollPhysics ?? const ScrollPhysics();

    verticalScrollbarBehavior =
        widget.verticalScrollbarBehavior ?? scrollbarBehavior.HIDE;

    setupButtonDefaultValues();

    if (widget.listCustomTabs == null) {
      renderListTabs();
    } else {
      tabs = widget.listCustomTabs!;
    }
  }

  void setupButtonDefaultValues() {
    // Skip button
    onSkipPress = widget.onSkipPress ??
        () {
          if (!isAnimating()) {
            if (lengthSlide > 0) {
              tabController.animateTo(lengthSlide - 1);
            }
          }
        };

    showSkipBtn = widget.showSkipBtn ?? true;
    renderSkipBtn = widget.renderSkipBtn ?? const Text('SKIP', style: TextStyle(color: Color(0xff000000)),);
    skipButtonStyle = widget.skipButtonStyle ?? const ButtonStyle(splashFactory: NoSplash.splashFactory);

    // Prev button
    if (showSkipBtn) {
      showPrevBtn = false;
    } else {
      showPrevBtn = widget.showPrevBtn ?? true;
    }

    renderPrevBtn = widget.renderPrevBtn ??
        Text(
          "PREV",
          style: TextStyle(color: Colors.white),
        );
    prevButtonStyle = widget.prevButtonStyle ?? ButtonStyle();

    showNextBtn = widget.showNextBtn ?? true;

    // Done button
    onDonePress = widget.onDonePress ?? () {};
    renderDoneBtn = widget.renderDoneBtn ??
        Text(
          "DONE",
          style: TextStyle(color: Colors.white),
        );
    doneButtonStyle = widget.doneButtonStyle ?? ButtonStyle();
    showDoneBtn = widget.showDoneBtn ?? true;

    // Next button
    renderNextBtn = widget.renderNextBtn ??
        Text(
          "NEXT",
          style: TextStyle(color: Colors.white),
        );
    nextButtonStyle = widget.nextButtonStyle ?? ButtonStyle();
  }

  void goToTab(int index) {
    if (index < tabController.length) {
      tabController.animateTo(index);
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    tabController.dispose();
    streamCurrentTabIndex.close();
  }

  // Checking if tab is animating
  bool isAnimating() {
    Animation<double>? animation = tabController.animation;
    if (animation != null) {
      return animation.value - animation.value.truncate() != 0;
    } else {
      return false;
    }
  }

  bool isRTLLanguage(String language) {
    return rtlLanguages.contains(language);
  }


/// ------------------------------------------------------------------------------------------------------------------------------------

  // 움직이는 점
  Widget movingDot() {
    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: backgroundDotList(),
          ),
        ),
        if (typeDotAnimation == dotSliderAnimation.DOT_MOVEMENT) /// DotAnimation 이 애니메이션 적용된 타입일 경우
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: colorActiveDot.withOpacity(dotIndicatorOpacity),
                  borderRadius: BorderRadius.circular(sizeDot / 2)
              ),
              width: sizeDot,
              height: sizeDot,
              margin: EdgeInsets.only(
                  left: isRTLLanguage(Localizations.localeOf(context).languageCode)
                      ? marginRightDotFocused
                      : marginLeftDotFocused,
                  right: isRTLLanguage(Localizations.localeOf(context).languageCode)
                      ? marginLeftDotFocused
                      : marginRightDotFocused),
            ),
          )
        else if (typeDotAnimation == dotSliderAnimation.NOTHING) /// DotAnimation 이 애니메이션 효과 제거된 타입일 경우
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: colorActiveDot.withOpacity(dotIndicatorOpacity),
                  borderRadius: BorderRadius.circular(sizeDot / 2)
              ),
              width: sizeDot,
              height: sizeDot,
              margin: EdgeInsets.only(
                  left: isRTLLanguage(Localizations.localeOf(context).languageCode)
                      ? nothingMarginRight
                      : nothingMarginLeft,
                  right: isRTLLanguage(Localizations.localeOf(context).languageCode)
                      ? nothingMarginLeft
                      : nothingMarginRight
              ),
            ),
          )
        else
          Container()
      ],
    );
  }

  Widget renderDotIndicator() {
    if(dotPositionTop == true) {
      return showDotIndicator
          ? movingDot()
          : Container();
    }
    else if(dotPositionTop == false){
      // todo : ??
      return Container();
    }
    else{
      return Container();
    }
  }

  Widget v2RenderNavigationBar() {
    return StreamBuilder<int>(
        stream: streamCurrentTabIndex.stream,
        builder: (context, snapshot) {
          int currentTabIndex = snapshot.data ?? 0;
          return Container(
            // alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            // height: 50,
            child: currentTabIndex + 1 == lengthSlide
                ? showDoneBtn /// 완료 버튼 렌더링
                ? buildDoneButton()
                : const SizedBox.shrink()
                : showNextBtn /// 다음 버튼 렌더링
                ? buildNextButton()
                : const SizedBox.shrink(),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // Full screen view
    if (widget.hideStatusBar == true) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []); // Migarted
    }

    /// 구역 분리 처리완료
    return Scaffold(
      backgroundColor: widget.backgroundColorAllSlides ?? Colors.transparent,
      body: DefaultTabController(
        length: lengthSlide,
        child: Column(
          children: [
            // 상단
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.125,
              width: MediaQuery.of(context).size.width,
              child: renderDotIndicator(),
            ),
            // 중단
            Expanded(
              child: TabBarView(
                controller: tabController,
                physics: isScrollable ? scrollPhysics : const NeverScrollableScrollPhysics(),
                children: tabs,
              )
            ),
            // 하단
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                child: v2RenderNavigationBar(),
              ),
            ),
          ],
        )
      ),
    );
  }



/// build Code ------------------------------------------------------------------------------------------------------------------------------------

  Widget buildDotIndicator() {
    /// 슬라이드 의 마지막 부분에서는 DotIndicator 가려짐 처리 된다.
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: backgroundDotList(),
        ),
        if (typeDotAnimation == dotSliderAnimation.DOT_MOVEMENT) /// dot이 움직이면서 이동
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: colorActiveDot.withOpacity(dotIndicatorOpacity),
                  borderRadius: BorderRadius.circular(sizeDot / 2)),
              width: sizeDot,
              height: sizeDot,
              margin: EdgeInsets.only(
                  left: isRTLLanguage(Localizations.localeOf(context).languageCode)
                      ? marginRightDotFocused
                      : marginLeftDotFocused,
                  right: isRTLLanguage(Localizations.localeOf(context).languageCode)
                      ? marginLeftDotFocused
                      : marginRightDotFocused),
            ),
          )
        else if (typeDotAnimation == dotSliderAnimation.NOTHING) /// 애니메이션 효과 없음
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: colorActiveDot.withOpacity(dotIndicatorOpacity),
                  borderRadius: BorderRadius.circular(sizeDot / 2)),
              width: sizeDot,
              height: sizeDot,
              margin: EdgeInsets.only(
                  left: isRTLLanguage(Localizations.localeOf(context).languageCode)
                      ? nothingMarginRight
                      : nothingMarginLeft,
                  right: isRTLLanguage(Localizations.localeOf(context).languageCode)
                      ? nothingMarginLeft
                      : nothingMarginRight
              ),
            ),
          )
        else
          Container()
      ],
    );
  }

  Widget buildNextButton() {
    /// 기존 코드
    //   return TextButton(
    //     key: nextButtonKey,
    //     onPressed: () {
    //       if (!isAnimating()) {
    //         tabController.animateTo(tabController.index + 1);
    //       }
    //     },
    //     style: nextButtonStyle,
    //     child: renderNextBtn,
    //   );
    /// 수정코드
    return ElevatedButton(
      key: nextButtonKey,
      onPressed: () {
        if (!isAnimating()) {
          tabController.animateTo(tabController.index + 1);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor : QuickaColor.Primary_Blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const Text(
        '다음',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          // height: 1.5
        ),
      ),
    );
  }

  Widget buildDoneButton() {
    /// 기존 코드
    // return TextButton(
    //   key: doneButtonKey,
    //   onPressed: onDonePress,
    //   style: doneButtonStyle,
    //   child: renderDoneBtn,
    // );
    /// 수정코드
    return ElevatedButton(
      key: nextButtonKey,
      onPressed: () {
        if (!isAnimating()) {
          /// 퀵카이브 시작하기
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor : QuickaColor.Primary_Blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const Text(
        '퀵카이브 시작하기',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          // height: 1.5
        ),
      ),
    );
  }

  /// 사용 보류 상태
  Widget buildSkipButton() {
    /// 슬라이드 의 마지막 부분에서는 skip 버튼이 가려짐 처리 된다.
    return Opacity(
      opacity: dotIndicatorOpacity,
      child: TextButton(
        key: skipButtonKey,
        onPressed: onSkipPress,
        style: skipButtonStyle,
        child: renderSkipBtn,
      ),
    );
  }
  /// 사용 보류 상태
  Widget buildPrevButton() {
    if (tabController.index == 0) {
      return Container(width: MediaQuery.of(context).size.width / 4);
    } else {
      return TextButton(
        key: prevButtonKey,
        onPressed: () {
          if (!isAnimating()) {
            tabController.animateTo(tabController.index - 1);
          }
        },
        style: prevButtonStyle,
        child: renderPrevBtn,
      );
    }
  }






/// rendering Code ---------------------------------------------------------------------------------------------------------------------------------

  Widget renderNavigationBar() {
    return Positioned(
      bottom: 20.0,
      left: 0.0,
      right: 0.0,
      child: StreamBuilder<int>(
          stream: streamCurrentTabIndex.stream,
          builder: (context, snapshot) {
            int currentTabIndex = snapshot.data ?? 0;
            return Container(
              // alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              // height: 50,
              child: currentTabIndex + 1 == lengthSlide
                  ? showDoneBtn /// 완료 버튼 렌더링
                  ? buildDoneButton()
                  : const SizedBox.shrink()
                  : showNextBtn /// 다음 버튼 렌더링
                  ? buildNextButton()
                  : const SizedBox.shrink(),
            );
          }
      ),
    );
  }

  Widget renderSkipButton() {
    /// skip 버튼 렌더링 코드
    return Positioned(
      // top: 0,
        bottom: 10,
        right: 0,
        left: 0,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 4,
          child: showSkipBtn
              ? buildSkipButton()
              : (showPrevBtn ? buildPrevButton() : Container()),
        )
    );
  }

  /// 렌더링 다음 버튼
  Widget renderNextButton() {
    return Positioned(
        // top: 0,
        bottom: 10,
        right: 0,
        left: 0,
        child: Container(
          // alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          // width: MediaQuery.of(context).size.width / 4,
          child: showNextBtn
              ? buildNextButton() /// 위젯 적용
              : Container(),
        )
    );
  }

  Widget renderTop() {
    return Positioned(
        top: 50,
        left: 10.0,
        right: 10.0,
        child:
        Container(
          // color: Colors.yellow,
          child: Row(
            children: <Widget>[
              if(dotPositionTop == true) ...[
                // Dot indicator
                Flexible(
                  child: showDotIndicator
                      ? buildDotIndicator()
                      : Container(),
                ),
              ],
            ],
          ),
        )
    );
  }
  
  Widget renderBottom() {
    return Positioned(
      bottom: 20.0,
      left: 10.0,
      right: 10.0,
      child: Row(
        children: <Widget>[
          if(dotPositionTop == false) ...[
            // Dot indicator
            Flexible(
              child: showDotIndicator
                  ? buildDotIndicator()
                  : Container(),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget>? renderListTabs() {
    for (var i = 0; i < lengthSlide; i++) {
      final scrollController = ScrollController();
      scrollControllers.add(scrollController);
      tabs.add(
        renderTab(
          scrollController,
          slides?[i].widgetTitle,
          slides?[i].title,
          slides?[i].maxLineTitle,
          slides?[i].styleTitle,
          slides?[i].marginTitle,
          slides?[i].widgetDescription,
          slides?[i].description,
          slides?[i].maxLineTextDescription,
          slides?[i].styleDescription,
          slides?[i].marginDescription,
          slides?[i].pathImage,
          slides?[i].widthImage,
          slides?[i].heightImage,
          slides?[i].foregroundImageFit,
          slides?[i].centerWidget,
          slides?[i].onCenterItemPress,
          slides?[i].backgroundColor,
          slides?[i].colorBegin,
          slides?[i].colorEnd,
          slides?[i].directionColorBegin,
          slides?[i].directionColorEnd,
          slides?[i].backgroundImage,
          slides?[i].backgroundImageFit,
          slides?[i].backgroundOpacity,
          slides?[i].backgroundOpacityColor,
          slides?[i].backgroundBlendMode,
        ),
      );
    }
    return tabs;
  }

  /// 정지해있는 배경점 List
  List<Widget> backgroundDotList() {
    return List.generate(lengthSlide, (index) {
      return backgroundDot(
        radius: sizeDots[index],
        color: colorDot,
        opacity: dotIndicatorOpacity * opacityDots[index],
        index: index,
      );
    });
  }

  /// 정지해있는 배경점 1개
  Widget backgroundDot({
    required double radius,
    required Color color,
    required double opacity,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => tabController.animateTo(index),
      child: Opacity(
        opacity: opacity,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
          ),
          width: radius,
          height: radius,
          margin: EdgeInsets.only(
              left: radius/2,
              right: radius/2
          ),
        ),
      ),
    );
  }





  Widget renderTab(
    ScrollController scrollController,

    // Title
    Widget? widgetTitle,
    String? title,
    int? maxLineTitle,
    TextStyle? styleTitle,
    EdgeInsets? marginTitle,

    // Description
    Widget? widgetDescription,
    String? description,
    int? maxLineTextDescription,
    TextStyle? styleDescription,
    EdgeInsets? marginDescription,

    // Image
    String? pathImage,
    double? widthImage,
    double? heightImage,
    BoxFit? foregroundImageFit,

    // Center Widget
    Widget? centerWidget,
    void Function()? onCenterItemPress,

    // Background color
    Color? backgroundColor,
    Color? colorBegin,
    Color? colorEnd,
    AlignmentGeometry? directionColorBegin,
    AlignmentGeometry? directionColorEnd,

    // Background image
    String? backgroundImage,
    BoxFit? backgroundImageFit,
    double? backgroundOpacity,
    Color? backgroundOpacityColor,
    BlendMode? backgroundBlendMode,
  ) {
    final listView = ListView(
      controller: scrollController,
      children: <Widget>[
        Container(
          // Title
          margin: marginTitle ??
              const EdgeInsets.only(top: 70.0, bottom: 50.0, left: 20.0, right: 20.0),
          child: widgetTitle ??
              Text(
                title ?? '',
                style: styleTitle ??
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                maxLines: maxLineTitle ?? 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
        ),

        // Image or Center widget
        GestureDetector(
          onTap: onCenterItemPress,
          child: pathImage != null
              ? Image.asset(
                  pathImage,
                  width: widthImage ?? 200.0,
                  height: heightImage ?? 200.0,
                  fit: foregroundImageFit ?? BoxFit.contain,
                )
              : Center(child: centerWidget ?? Container()),
        ),

        // Description
        Container(
          margin: marginDescription ??
              const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
          child: widgetDescription ??
              Text(
                description ?? '',
                style: styleDescription ??
                    const TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
                maxLines: maxLineTextDescription ?? 100,
                overflow: TextOverflow.ellipsis,
              ),
        ),
      ],
    );
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: backgroundImage != null
          ? BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: backgroundImageFit ?? BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  backgroundOpacityColor != null
                      ? backgroundOpacityColor
                          .withOpacity(backgroundOpacity ?? 0.5)
                      : Colors.black.withOpacity(backgroundOpacity ?? 0.5),
                  backgroundBlendMode ?? BlendMode.darken,
                ),
              ),
            )
          : BoxDecoration(
              gradient: LinearGradient(
                colors: backgroundColor != null
                    ? [backgroundColor, backgroundColor]
                    : [
                        colorBegin ?? Colors.amberAccent,
                        colorEnd ?? Colors.amberAccent
                      ],
                begin: directionColorBegin ?? Alignment.topLeft,
                end: directionColorEnd ?? Alignment.bottomRight,
              ),
            ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 60.0),
        child: verticalScrollbarBehavior != scrollbarBehavior.HIDE
            ? Platform.isIOS
                ? CupertinoScrollbar(
                    controller: scrollController,
                    thumbVisibility: verticalScrollbarBehavior == // Migarted
                        scrollbarBehavior.SHOW_ALWAYS,
                    child: listView,
                  )
                : Scrollbar(
                    controller: scrollController,
                    thumbVisibility: verticalScrollbarBehavior == // Migarted
                        scrollbarBehavior.SHOW_ALWAYS,
                    child: listView,
                  )
            : listView,
      ),
    );
  } // renderTab end


}
