import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class ChangeStatusBar extends StatelessWidget {
  const ChangeStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /// 상태바 설정 방식
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     /// ios
    //     // statusBarBrightness: Brightness.dark, // ios 상태바 텍스트 컬러 = white
    //     statusBarBrightness: Brightness.light,   // ios 상태바 텍스트 컬러 = black
    //     /// android
    //     statusBarIconBrightness: Brightness.light,// Android 텍스트 컬러
    //     statusBarColor: Colors.red  // Android 백그라운드 컬러
    //   )
    // );

    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        /// AppBar 가 있을때 상태바 처리
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,   // ios 상태바 텍스트 컬러 = black
        ),
        leading:
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, size: 24, color: Color(0xff747474)),
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
      body: SafeArea(
        child: Center(child: Text("Hi there Annotated"))
      )
    );

    /// 일반적인 상태바 처리
    // return const AnnotatedRegion(
    //   value: SystemUiOverlayStyle(
    //     statusBarBrightness: Brightness.light,   // ios 상태바 텍스트 컬러 = black
    //   ),
    //   child: Scaffold(
    //       backgroundColor: Colors.teal,
    //       body: SafeArea(
    //           child: Center(child: Text("Hi there Annotated"))
    //       )
    //   ),
    // );

  }

}
