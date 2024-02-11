import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingHistoryOrder extends StatelessWidget {
  const LoadingHistoryOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        width: Get.width,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
