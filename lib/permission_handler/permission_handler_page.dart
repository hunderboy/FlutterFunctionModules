import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_function_modules/permission_handler/permission_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerPage extends GetView<PermissionController> {
  const PermissionHandlerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PermissionController());
    Permission.camera.request();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Handler'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     controller.getNotificationPermission();
              //   },
              //   child: Text("Notification"),
              // ),
              ElevatedButton(
                onPressed: () {
                  controller.getCameraPermissionCheck();
                },
                child: Text("Camera"),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     controller.getStoragePermission();
              //   },
              //   child: Text("Storage"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
