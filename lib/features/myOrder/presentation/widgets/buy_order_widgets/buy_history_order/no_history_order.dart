import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoHistoryOrder extends StatelessWidget {
  const NoHistoryOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 80,
        width: Get.width,
        child: Center(child: Text("You have not placed any order in past")),
      ),
    );
  }
}
