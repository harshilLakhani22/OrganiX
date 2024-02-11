import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/routes/app_routes.dart';

class BuyNoCurrentOrder extends StatelessWidget {
  const BuyNoCurrentOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 120,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No current order available", style: TextStyle(fontSize: 16),),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.buyJivamrut),
              child: Text("Make Order"),
            ),
          ],
        ),

      ),
    );
  }
}
