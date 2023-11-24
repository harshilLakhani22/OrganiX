import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/firebase_services/splash_services.dart';
import '../../../myOrder/presentation/controller/my_order_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String userId = "";
  // static SharedPreferences? pref;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.isLogin(context);
    // getPrefrences();
  }

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut(() => OrderController());
    // Get.put(OrderController());

    return SizedBox(
      height: Get.height,
      child: const Image(
        image: AssetImage('assets/splash_screen2.jpg'),
      ),
    );
  }
}
