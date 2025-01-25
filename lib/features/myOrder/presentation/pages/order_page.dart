import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/common/widgets/appbar/auth_appbar.dart';
import 'package:organix/features/myOrder/presentation/controller/order_page_controller.dart';
import 'package:organix/features/myOrder/presentation/pages/buy_order_page.dart';
import 'package:organix/features/myOrder/presentation/pages/sell_order_page.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';

class MyOrderPageScreen extends StatelessWidget {
  const MyOrderPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderPageController orderPageController =
    Get.put(OrderPageController());

    return Scaffold(
      appBar:
      // MAuthAppBar(title: title),
      AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        title: Text("strYourOrders".tr, style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: MSizes.lg,
        ),),
        backgroundColor: MColors.appBar,
        centerTitle: true,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            // width: double.infinity,
            decoration: const BoxDecoration(
              color: MColors.secondary, // Customize the background color
            ),
            child: TabBar(
              controller: orderPageController.tabController,
              indicator: const BoxDecoration(
                color: MColors.accent, // Customize the indicator color

                  borderRadius: BorderRadius.all(Radius.circular(MSizes.smmd))
              ),
              tabs: orderPageController.myTabs.map((Tab tab) {
                return Tab(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      tab.text!,
                      style: const TextStyle(
                        fontSize: MSizes.md,
                        fontWeight: FontWeight.w400,
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
        children: const [
          BuyOrderPageScreen(),
          SellOrderPageScreen(),
        ],
      ),
    );
  }
}
