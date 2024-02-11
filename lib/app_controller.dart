import 'package:get/get.dart';

import 'features/myOrder/presentation/controller/buy_order_page_controller.dart';

class AppController extends GetxController {
  void initializeControllers() {
    Get.put(BuyOrderController());
    // Add other controllers here
  }
}
