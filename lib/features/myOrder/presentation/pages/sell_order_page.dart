import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/features/myOrder/presentation/controller/buy_order_page_controller.dart';
import 'package:organix/features/myOrder/presentation/controller/sell_order_page_controller.dart';
import 'package:organix/features/myOrder/presentation/widgets/sell_order_widget/sell_current_order/sell_current_order_card.dart';
import 'package:organix/features/myOrder/presentation/widgets/sell_order_widget/sell_current_order/sell_loading_current_order.dart';
import 'package:organix/features/myOrder/presentation/widgets/sell_order_widget/sell_history_order/sell_history_order_card.dart';

import '../widgets/buy_order_widgets/buy_current_order/loading_current_order.dart';
import '../widgets/buy_order_widgets/buy_history_order/loading_history_order.dart';
import '../widgets/buy_order_widgets/buy_history_order/no_history_order.dart';

class SellOrderPageScreen extends StatelessWidget {
  const SellOrderPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final BuyOrderController orderController = Get.put(BuyOrderController());
    final SellOrderController sellOrderController = Get.put(SellOrderController());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current Sell Orders",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              if (sellOrderController.isLoading.value) {
                return const BuyLoadingCurrentOrder();
              }
              var currentOrders = sellOrderController.currentOrders
                  .where((order) => order.isCurrentOrder)
                  .toList();

              if (currentOrders.isNotEmpty) {
                return Column(
                  children: currentOrders.map((order) {
                    return SellCurrentOrderCard(
                      order: order,
                      onCancelOrder: () {
                        sellOrderController.cancelOrder(order);
                      },
                    );
                  }).toList(),
                );
              } else {
                return SellNoCurrentOrder();
              }
            }),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 5,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Selling History",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              if (sellOrderController.isLoading.value) {
                return LoadingHistoryOrder(); // Show loading indicator
              }
              var historyOrders = sellOrderController.currentOrders
                  .where((order) => !order.isCurrentOrder)
                  .toList();
              if(historyOrders.isNotEmpty){
                return Column(
                  children: sellOrderController.currentOrders
                      .where((order) => !order.isCurrentOrder).map((order) {
                    return SellHistoryOrderCard(order: order);
                  }).toList(),
                );
              } else{
                return NoHistoryOrder();
              }

            })
          ],
        ),
      ),
    );
  }
}
