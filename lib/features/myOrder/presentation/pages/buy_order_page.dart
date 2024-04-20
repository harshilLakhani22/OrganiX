import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/utils/constants/colors.dart';
import 'package:organix/core/utils/constants/sizes.dart';
import 'package:organix/features/myOrder/presentation/controller/buy_order_page_controller.dart';

import '../widgets/buy_order_widgets/buy_current_order/buy_current_order_card.dart';
import '../widgets/buy_order_widgets/buy_current_order/loading_current_order.dart';
import '../widgets/buy_order_widgets/buy_current_order/no_current_order.dart';
import '../widgets/buy_order_widgets/buy_history_order/history_order_card.dart';
import '../widgets/buy_order_widgets/buy_history_order/loading_history_order.dart';
import '../widgets/buy_order_widgets/buy_history_order/no_history_order.dart';

class BuyOrderPageScreen extends StatelessWidget {
  const BuyOrderPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BuyOrderController buyOrderController = Get.put(BuyOrderController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Current Orders
            Text(
              "strCurrentBuyOrders".tr,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(
              thickness: 1,
              indent: 2,
              endIndent: 10,
            ),
            const SizedBox(height: MSizes.spaceBtwItems),

            /// Curr Buy Order
            Obx(() {
              if (buyOrderController.isLoading.value) {
                return const BuyLoadingCurrentOrder();
              }
              var currentOrders = buyOrderController.currentOrders
                  .where((order) =>
                      order.isCurrentOrder && !order.isCancelFromFarmer)
                  .toList();

              if (currentOrders.isNotEmpty) {
                return Column(
                  children: currentOrders.map((order) {
                    return BuyCurrentOrderCard(
                      order: order,
                      onCancelOrder: () {
                        buyOrderController.cancelOrder(order);
                      },
                    );
                  }).toList(),
                );
              } else {
                return const BuyNoCurrentOrder();
              }
            }),

            const SizedBox(height: MSizes.spaceBtwSections),
            const Divider(thickness: 5, color: MColors.buttonDisabled,),
            const SizedBox(height: MSizes.spaceBtwSections),

             Text(
              "strBuyingHistory".tr,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(
              thickness: 1,
              indent: 2,
              endIndent: 10,
            ),
            const SizedBox(height: MSizes.spaceBtwItems),
            Obx(() {
              if (buyOrderController.isLoading.value) {
                return const LoadingHistoryOrder(); // Show loading indicator
              }
              var historyOrders = buyOrderController.currentOrders
                  .where((order) => !order.isCurrentOrder)
                  .toList();
              if (historyOrders.isNotEmpty) {
                return Column(
                  children: buyOrderController.currentOrders
                      .where((order) => !order.isCurrentOrder)
                      .map((order) {
                    return BuyHistoryOrderCard(order: order);
                  }).toList(),
                );
              } else {
                return const NoHistoryOrder();
              }
            })
          ],
        ),
      ),
    );
  }
}
