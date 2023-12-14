import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import './../ui/components/alert_dialog.dart';
import 'globals.dart' as global;

class LocationHandler {
  Future<void> _handlePermissionDeniedForever() async {
    await showDialog(
      context: global.navigatorKey.currentState!.overlay!.context,
      builder: (context) {
        return CustomDialogBox(
          title: 'Permission Denied',
          content:
              'Location permissions to the app are denied forever. You need to change the settings to capture the current location',
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CLOSE'),
            ),
            TextButton(
              onPressed: () async {
                await Geolocator.openAppSettings();
              },
              child: const Text('GO TO SETTINGS'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handlePermissionDeniedAgain() async {
    await showDialog(
      context: global.navigatorKey.currentState!.overlay!.context,
      builder: (context) {
        return CustomDialogBox(
          title: 'Permission Denied',
          content:
              'The app requires location permissions to capture the current location. You need to allow the app to use the location services',
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('GO'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleServiceDenied() async {
    await showDialog(
      context: global.navigatorKey.currentState!.overlay!.context,
      builder: (context) {
        return CustomDialogBox(
          title: 'Location Services Disabled',
          content:
              'Location services are disabled. These services are needed by the app to capture the current location',
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CLOSE'),
            ),
            TextButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
              },
              child: const Text('GO TO SETTINGS'),
            ),
          ],
        );
      },
    );
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      await _handleServiceDenied();
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        await _handlePermissionDeniedForever();
        return Future.error(
            'Location permissions are permanently denied, we cannot request permission');
      }

      if (permission == LocationPermission.denied) {
        await _handlePermissionDeniedAgain();
        return Future.error('Location permissions are denied');
      }
    }

    final location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      forceAndroidLocationManager: true,
    );

    return location;
  }
}
