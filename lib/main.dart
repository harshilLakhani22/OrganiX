import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organix/core/local_languages/languages.dart';
import 'package:organix/features/myOrder/presentation/controller/buy_order_page_controller.dart';
import 'package:organix/features/splashScreen/presentation/pages/splash_page.dart';
import 'package:organix/firebase_options.dart';
import 'package:organix/routes/app_pages.dart';
import 'package:organix/routes/app_routes.dart';

import 'features/buyJivamrut/presentation/controller/buyJivamrutController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  final BuyOrderController orderController = Get.put(BuyOrderController());
  final BuyJivamrutController buyJivamrutController = Get.put(BuyJivamrutController());

  runApp( MyApp());
}

// GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // final AppController appController = Get.put(AppController());
  final BuyJivamrutController buyJivamrutController = Get.put(BuyJivamrutController());


  @override
  Widget build(BuildContext context) {
    // appController.initializeControllers();
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff598216)),
        // backgroundColor: const Color(0xffe6f6f0),
      ),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.list,
      initialRoute: AppRoutes.initialRoute,
      home: const SplashScreen(),
      translations: Languages(),
      locale: const Locale('en', 'US'),
    );
  }
}
