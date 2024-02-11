import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/features/myOrder/presentation/controller/order_page_controller.dart';
import 'package:organix/features/myOrder/presentation/pages/buy_order_page.dart';
import 'package:organix/features/myOrder/presentation/pages/sell_order_page.dart';

class MyOrderPageScreen extends StatelessWidget {
  const MyOrderPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderPageController orderPageController =
    Get.put(OrderPageController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey, // Customize the background color
            ),
            child: TabBar(
              controller: orderPageController.tabController,
              indicator: BoxDecoration(
                color: Color(0xff598216), // Customize the indicator color
              ),
              tabs: orderPageController.myTabs.map((Tab tab) {
                return Tab(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      tab.text!,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Customize the text color
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: orderPageController.tabController,
        children: [
          BuyOrderPageScreen(),
          SellOrderPageScreen(),
        ],
      ),
    );
  }
}
