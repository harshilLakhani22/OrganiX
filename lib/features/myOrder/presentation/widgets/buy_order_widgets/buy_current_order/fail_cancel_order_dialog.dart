import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/presentation/widgets/rounded_button.dart';

class BuyFailCancelOrderDialog extends StatelessWidget {
  const BuyFailCancelOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "You can't cancel the order",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Divider(),
            Text("process of making jivamrut has been started. Now you can not cancel the order",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: Get.back, child: Text("OK"))
                // RoundButton(title: "Cancel", onTap: Get.back)
              ],
            )
          ],
        ),
      ),
    );
  }
}
