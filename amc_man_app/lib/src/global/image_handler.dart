import 'dart:io';

import 'package:amc_man_app/src/logger.dart';
import 'package:amc_man_app/src/ui/components/alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'globals.dart' as global;

class ImageHandler {
  final imagePicker = ImagePicker();

  void _handlePermissionDeniedForever() {
    showDialog(
      context: global.navigatorKey.currentContext!,
      builder: (context) {
        return CustomDialogBox(
          title: 'Permission Denied',
          content:
              'Camera permissions to the app are denied forever. You need to change the settings to capture image assets',
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(global.navigatorKey.currentContext!).pop();
              },
              child: const Text('CLOSE'),
            ),
            TextButton(
              onPressed: () async {
                await openAppSettings();
              },
              child: const Text('GO TO SETTINGS'),
            ),
          ],
        );
      },
    );
  }

  void _handlePermissionDeniedAgain() {
    showDialog(
      context: global.navigatorKey.currentContext!,
      builder: (context) {
        return CustomDialogBox(
          title: 'Permission Denied',
          content:
              'The app requires camera permissions to capture the assets. You need to allow the app to use the camera',
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(global.navigatorKey.currentContext!).pop();
              },
              child: const Text('GO'),
            ),
          ],
        );
      },
    );
  }

  Future<File> pickFile() async {
    PermissionStatus havePermission = await Permission.camera.status;
    if (kDebugMode) {
      print(havePermission.toString());
    }
    if (havePermission.isDenied) {
      havePermission = await Permission.camera.request();
      if (havePermission.isPermanentlyDenied) {
        _handlePermissionDeniedForever();
        return Future.error('Camera permission denied permanently');
      } else if (havePermission.isDenied) {
        _handlePermissionDeniedAgain();
        return Future.error('Camera permission denied again');
      }
    }

    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.camera);
      final file = File(pickedFile!.path);
      return file;
    } on Exception catch (e) {
      logger.e('Error: Picking Image: ${e.toString()}');
      throw Error();
    }
  }

  Future<File?> retrieveLostImageFile() async {
    final LostDataResponse response = await imagePicker.retrieveLostData();

    if (response.isEmpty) {
      return null;
    } else {
      if (response.file != null) {
        final file = File(response.file!.path);
        return file;
      } else {
        logger.e(response.exception.toString());
        return null;
      }
    }
  }

  Widget previewImage(File imageFile) {
    return Semantics(
      label: 'asset_photo',
      image: true,
      child: Image.file(
        imageFile,
        fit: BoxFit.cover,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          } else {
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
              child: child,
            );
          }
        },
      ),
    );
  }
}
