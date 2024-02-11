import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:organix/features/myOrder/data/model/sell_order_model.dart';

import '../../../../data/model/buy_order_model.dart';
class SellCurrentOrderCard extends StatelessWidget {
  GetStorage box = GetStorage();
  final SellOrderModel order;
  final VoidCallback onCancelOrder;

  SellCurrentOrderCard({
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
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/organic1.jpeg"),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                height: 120,
                margin: const EdgeInsets.all(10),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.rawMaterialType,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text("Quantity :- ${order.quantity} kg"),
                  const SizedBox(
                    height: 7,
                  ),
                  Text("Date :- ${DateFormat.yMd().format(order.orderDate)}"),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onCancelOrder();
                    },
                    style: ButtonStyle(
                      backgroundColor: order.isAcceptedFromAdmin
                          ? MaterialStateProperty.all(Colors.grey)
                          : MaterialStateProperty.all(const Color(0xff598216)),
                    ),
                    child: order.isAcceptedFromAdmin ? Text("Order Placed") :  Text("Cancel Order"),
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
