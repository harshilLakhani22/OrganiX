import 'package:get/get.dart';

import 'features/myOrder/presentation/controller/my_order_controller.dart';

class AppController extends GetxController {
  void initializeControllers() {
    Get.put(OrderController());
    // Add other controllers here
  }
}
