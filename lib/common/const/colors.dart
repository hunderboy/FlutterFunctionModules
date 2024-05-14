// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'dart:ui';

/// 추후 ThemeData 로 변경될 예정
/// 라이트모드 / 다크모드 지원 혹은 유저에 의한 색 변경 기능까지 생각하면 ThemeData를 쓰는게 맞는 것 같다.
/// 대신 내가 자주 쓰는 색 등은 따로 상수로 뺄 계획이다.
/// 색이 많이 필요할 경우 결국 앱 전체가 아닌 기능별로 ThemeData와  color를 지정해서 써야한다.
class QuickaColor {
  QuickaColor._(); // QuickaColor._() 생성자는 private constructor로 인스턴스화를 막아준다.

  static const Primary_Blue = Color(0xFF146EFF);
  // static const Primary_Blue = Color(0xFF146EFF); // 004CC7;

  static const Grey_100 = Color(0xFF13141A);
  static const Grey_90 = Color(0xE613141A);
  static const Grey_80 = Color(0xFF515253);
  static const Grey_70 = Color(0xFF79797C);
  static const Grey_60 = Color(0xFF909091);
  static const Grey_50 = Color(0xFF9D9D9E);
  static const Grey_40 = Color(0xFFACACAD);
  static const Grey_30 = Color(0xFFC2C3C4);
  static const Grey_20 = Color(0xFFDCDCDE);
  static const Grey_10 = Color(0xFFEEEEF0);

  static const GRAY_BACKGROUND = Color(0xFFF5F5F5);
  static const GRAY_BORDER = Color(0x0D1A1313);
  static const BACKGROUND_BLACK = Color(0xFF232329);
}


// 주색상
const PRIMARY_COLOR = Color(0xFF22A45D);
// 글자 색상
const BODY_TEXT_COLOR = Color(0xFF868686);
// 텍스트필드 배경 색상
const INPUT_BG_COLOR = Color(0xFFFBFBFB);
// 텍스트필드 테두리 색상
const INPUT_BORDER_COLOR = Color(0xFFF3F2F2);


// /// 싱글톤 예시
// class SingletonExample {
//   // 1. Private한 생성자 생성 (빈생성자 생성)
//   /// Dart에선 생성자가 없을경우 자동으로 Public한 생성자를 만들어 버린다.
//   /// 이를 막기위해 Private한 생성자를 만들어줘서 자동으로 만들어주는 생성자가 생성 되지 않도록 방지하는 것.
//   SingletonExample._privateConstructor();
//
//   // 2. 생성자를 호출
//   /// 생성자를 호출하고 반환된 SingletonExample 인스턴스를 _instance 변수에 할당
//   static final SingletonExample _instance = SingletonExample._privateConstructor();
//
//   // SingletonExample() 호출시에 _instance 변수를 반환
//   factory SingletonExample() {
//     return _instance;
//   }
// }




// BLACK
// const QuickaColor.Grey_100 = Color(0xFF13141A);
// const QuickaColor.BACKGROUND_BLACK = Color(0xFF232329); // QuickaColor.BACKGROUND_BLACK
// GRAY
// const QuickaColor.Grey_20 = Color(0xFFDCDCDE); // QuickaColor.Grey_20
// const QuickaColor.Grey_10 = Color(0xFFEEEEF0); // QuickaColor.Grey_10
// const QuickaColor.Grey_80 = Color(0xFF515253); // QuickaColor.Grey_80
// const QuickaColor.Grey_70 = Color(0xFF79797C); // QuickaColor.Grey_70
// const QuickaColor.Grey_60 = Color(0xFF909091); // QuickaColor.Grey_60
// const QuickaColor.Grey_30 = Color(0xFFC2C3C4); // QuickaColor.Grey_30
// const QuickaColor.GRAY_BORDER = Color(0x0D1A1313); // QuickaColor.QuickaColor.GRAY_BORDER

// BLUE
// const QuickaColor.Primary_Blue = Color(0xFF146EFF); // QuickaColor.Primary_Blue

