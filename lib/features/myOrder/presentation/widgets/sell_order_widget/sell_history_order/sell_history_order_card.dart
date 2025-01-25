import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organix/core/utils/constants/image_strings.dart';
import 'package:organix/features/myOrder/data/model/buy_order_model.dart';
import 'package:organix/features/myOrder/data/model/sell_order_model.dart';

import '../../../../../../core/utils/constants/sizes.dart';

class SellHistoryOrderCard extends StatelessWidget {
  final SellOrderModel order;

  const SellHistoryOrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: SizedBox(
          height: 90,
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/organic2.jpeg"),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  height: 120,
                  width: 150,
                  margin: const EdgeInsets.all(10),
                ),
              ),const SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "strJivamrut".tr,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: MSizes.xs),
                    Text("${"strQuantity".tr} :- ${order.quantity} kg"),
                    Text("${'strDate'.tr} :- ${DateFormat.yMd().format(order.orderDate)}"),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.asset(MImages.imgGreenTick),
                // child: AssetImage(MImages.imgGreenTick),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
