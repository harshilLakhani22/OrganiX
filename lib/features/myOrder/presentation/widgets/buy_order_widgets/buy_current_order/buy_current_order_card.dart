import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:organix/core/utils/constants/image_strings.dart';
import 'package:organix/core/utils/constants/sizes.dart';

import '../../../../data/model/buy_order_model.dart';

class BuyCurrentOrderCard extends StatelessWidget {
  final GetStorage box = GetStorage();
  final BuyOrderModel order;
  final VoidCallback onCancelOrder;

  BuyCurrentOrderCard({
    Key? key,
    required this.order,
    required this.onCancelOrder,
  }) : super(key: key);

  String? getUserUid() {
    return box.read('uid');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Card(
        child: Row(
          children: [
            /// Image
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(MImages.imgOrganic1),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(MSizes.borderRadiusMd),
                  ),
                ),
                height: 130,
                margin: const EdgeInsets.all(10),
              ),
            ),
            const SizedBox(width: MSizes.sm),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "strJivamrut".tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: MSizes.xs),
                  Text("${"strQuantity".tr} :- ${order.quantity} kg"),
                  const SizedBox(height: MSizes.xs),
                  Text(
                      "${'strDate'.tr} :- ${DateFormat.yMd().format(order.orderDate)}"),
                  const SizedBox(height: MSizes.sm),
                  ElevatedButton(
                    onPressed: () {
                      onCancelOrder();
                    },
                    style: ButtonStyle(
                      backgroundColor: order.isAcceptedFromAdmin
                          ? MaterialStateProperty.all(Colors.grey)
                          : MaterialStateProperty.all(const Color(0xff598216)),
                    ),
                    child: order.isAcceptedFromAdmin
                        ? Text("strOrderPlaced".tr, style: const TextStyle(color: Colors.white),)
                        : Text("strCancelOrder".tr, style: const TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
