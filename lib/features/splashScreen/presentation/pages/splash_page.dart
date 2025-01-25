import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../../../../core/firebase_services/splash_services.dart';
import '../../../../core/utils/constants/image_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String userId = "";
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
        image: AssetImage(MImages.imgSplashScreen,),
        fit: BoxFit.fill,
      ),
    );
  }
}
