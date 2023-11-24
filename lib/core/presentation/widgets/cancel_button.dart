import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: Get.back,
        child: const Icon(Icons.cancel, color: Color(0xff598216)),
      ),
    );
  }
}