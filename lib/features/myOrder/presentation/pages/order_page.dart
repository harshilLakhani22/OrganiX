import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/features/myOrder/presentation/controller/my_order_controller.dart';
import 'package:organix/features/myOrder/presentation/widgets/current_order/current_order_card.dart';
import 'package:organix/features/myOrder/presentation/widgets/current_order/loading_current_order.dart';
import 'package:organix/features/myOrder/presentation/widgets/history_order/history_order_card.dart';
import 'package:organix/features/myOrder/presentation/widgets/current_order/no_current_order.dart';
import 'package:organix/features/myOrder/presentation/widgets/history_order/loading_history_order.dart';
import 'package:organix/features/myOrder/presentation/widgets/history_order/no_history_order.dart';

class MyOrderPageScreen extends StatelessWidget {
  const MyOrderPageScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final OrderController orderController = Get.put(OrderController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Current Orders",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                if (orderController.isLoading.value) {
                  return LoadingCurrentOrder(); // Show loading indicator
                }

                var currentOrders = orderController.currentOrders
                    .where((order) => order.isCurrentOrder)
                    .toList();

                if (currentOrders.isNotEmpty) {
                  return Column(
                    children: currentOrders.map((order) {
                      return CurrentOrderCard(
                        order: order,
                        onCancelOrder: () {
                          orderController.cancelOrder(order);
                        },
                      );
                    }).toList(),
                  );
                } else {
                  return NoCurrentOrder();
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
                "History",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                if (orderController.isLoading.value) {
                  return LoadingHistoryOrder(); // Show loading indicator
                }
                var historyOrders = orderController.currentOrders
                    .where((order) => !order.isCurrentOrder)
                    .toList();
                if(historyOrders.isNotEmpty){
                  return Column(
                    children: orderController.currentOrders
                        .where((order) => !order.isCurrentOrder).map((order) {
                      return HistoryOrderCard(order: order);
                    }).toList(),
                  );
                } else{
                  return NoHistoryOrder();
                }

              })
            ],
          ),
        ),
      ),
    );
  }
}
