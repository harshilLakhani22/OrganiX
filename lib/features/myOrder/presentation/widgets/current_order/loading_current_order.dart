import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingCurrentOrder extends StatelessWidget {
  const LoadingCurrentOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 120,
        width: Get.width,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
