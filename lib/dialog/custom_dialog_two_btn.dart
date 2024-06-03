import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';


class CustomDialogTwoBtn extends StatelessWidget {
  CustomDialogTwoBtn({Key? key,
    required this.title,
    required this.negativeText,
    required this.positiveText,
    required this.negativeRoute,
    required this.positiveRoute,
    this.evaluationName,
    this.description,
    this.type,
    this.img
  }) : super(key: key);
  /// 필수
  String title;
  String negativeText;
  String positiveText;
  String negativeRoute;
  var positiveRoute;
  /// 필수아님
  String? evaluationName;
  String? description;
  String? type;
  String? img;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // 상단에 필요없는 부분을 투명하게 + 그림자 지우기
      // insetPadding: const EdgeInsets.symmetric(horizontal: 20), //dialog padding 조절
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(),
    );
  }

  contentBox() {
    // 가로일 때와 세로일 때 넓이 조절 (그 외는 똑같음)
    return OrientationBuilder(
      builder: (context, orientation) {
        return Container(
          width : (orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width         // 세로모드 일 때
              : MediaQuery.of(context).size.width * 0.4),  // 가로모드 일 때
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(0, 5), blurRadius: 10)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(title, style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),textAlign: TextAlign.center),
              ),
              if(evaluationName != null)...[
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(evaluationName!, style: const TextStyle(fontSize: 18, color: Color(0xff07BEB8), fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
              ],
              if(description != null)...[
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(description!, style: const TextStyle(fontSize: 14, color: Color(0xff747474), fontWeight: FontWeight.bold),textAlign: TextAlign.center)),
              ],
              Container(
                margin: const EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xff747474), backgroundColor: Colors.white, padding: const EdgeInsets.all(14),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                          elevation: 0, // foreground
                        ),
                        child: Text(negativeText, style: const TextStyle(fontSize: 14)),
                        onPressed: () {
                          if(negativeRoute == "back"){
                            Navigator.pop(context); // 뒤로가기
                            // Get.back();
                          }else{
                            // Get.find<ControllerLobby>().increase2();
                            Navigator.pushNamed(context, negativeRoute);
                          }
                        },
                      ),
                    ),
                    const Gap(20),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: const Color(0xff07BEB8), padding: const EdgeInsets.all(14),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))), // foreground
                        ),
                        child: Text(positiveText, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                        onPressed: () {
                          if (positiveRoute == 'pop') {
                            Navigator.pop(context); // 다이얼로그 끔
                          } else if(positiveRoute == 'setting') {
                      
                          } else {
                            // Navigator.pushNamed(context, positiveRoute);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}