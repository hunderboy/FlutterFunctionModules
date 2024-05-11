import 'package:flutter/material.dart';


class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key,
    required this.type,
    required this.title,
    required this.descriptions,
    required this.negativeText,
    required this.positiveText,
    this.img
  }) : super(key: key);
  final String type, title, descriptions, negativeText, positiveText;
  final   String? img;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      // 상단에 필요없는 부분을 투명하게 + 그림자 지우기
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return
      Container(
        padding: const EdgeInsets.all(22),
        margin: const EdgeInsets.only(top: 45),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(color: Colors.black,offset: Offset(0,5),
                  blurRadius: 10
              ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                // Text("알림",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff545454)),),
                Text(title, style: const TextStyle(fontSize: 16, color: Color(0xff545454))),
              ],
            ),
            const SizedBox(height: 15,),
            Text(descriptions, style: const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold,)),
            const SizedBox(height: 22,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(top:15 ,bottom:15 ,left:30 ,right:30 ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    elevation: 0,
                    primary: Colors.white, // background
                    onPrimary: Colors.black, // foreground
                  ),
                  child: Text(negativeText, style: const TextStyle(fontSize: 16)),
                  onPressed: () {
                    // Get.find<ControllerLobby>().increase2();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(top:15 ,bottom:15 ,left:30 ,right:30 ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    primary: const Color(0xff07BEB8), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Text(positiveText, style: const TextStyle(fontSize: 16)),
                  onPressed: () {
                    // Get.find<ControllerLobby>().increase2();
                  },
                ),
              ],
            ),

          ],
        ),
      );
  }
}

