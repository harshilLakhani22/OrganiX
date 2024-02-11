import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPageController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: "Buy Orders",
    ),
    Tab(
      text: "Sell Orders",
    )
  ];

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}