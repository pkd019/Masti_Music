import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("home")),
      body: SizedBox(
        width: double.infinity,
        height: Get.height,
        child: Image.asset(
          "assets/Christmas .png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
