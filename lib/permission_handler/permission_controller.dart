import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_function_modules/dialog/custom_dialog_two_btn.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class PermissionController extends GetxController {
  var cameraStatus = Permission.camera.status;
  late BuildContext context;

  void setContext(BuildContext ctx) {
    context = ctx;
  }

  getCameraPermission() async {
    var status = await cameraStatus;

    if (kDebugMode) {
      print('Status : $status');
    }
    if (status.isGranted) {
      Navigator.pushNamed(context, '/Ready');
    } else {
      getCameraPermissionCheck();
    }
  }

  getCameraPermissionCheck() async {
    var status = await cameraStatus;


    if (!status.isGranted) {
      showDialog(
        context: context,
        builder: (context) => CustomDialogTwoBtn(
          title: "카메라에 대한 허용을 거부하였습니다.",
          description: '기능 사용을 원하실 경우 휴대폰 설정에서\n해당 앱의 권한을 허용해 주세요.',
          negativeText: '닫기',
          positiveText: '설정하러 가기',
          negativeRoute: 'back',
          positiveRoute: 'setting',
        ),
      );
    }
  }

  // getNotificationPermission() async {
  //   var notiStatus = await Permission.notification.status;
  //   if (notiStatus.isGranted) {
  //   } else if (notiStatus.isDenied) {
  //     notiStatus = await Permission.notification.request();
  //     if (notiStatus.isPermanentlyDenied) {
  //       openAppSettings();
  //     }
  //   }
  // }
  //
  // getStoragePermission() async {
  //   var storageStatus = await Permission.storage.status;
  //   if (storageStatus.isGranted) {
  //   } else if (storageStatus.isDenied) {
  //     storageStatus = await Permission.storage.request();
  //     if (storageStatus.isPermanentlyDenied) {
  //       openAppSettings();
  //     }
  //   }
  // }


}
