import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organix/core/methods/methods.dart';
import 'package:organix/features/drawer/presentation/widgets/change_languages.dart';
import 'package:organix/features/drawer/presentation/widgets/open_url.dart';
import 'package:organix/features/myOrder/presentation/controller/buy_order_page_controller.dart';
import 'package:organix/routes/app_routes.dart';

import '../widgets/drawer_listTile.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetStorage box = GetStorage();

  final BuyOrderController orderController = Get.put(BuyOrderController());


  @override
  Widget build(BuildContext context) {
    String farmerName = box.read('farmerName') ?? '';
    String farmerEmail = box.read('farmerEmail') ?? '';
    String formattedFarmerName = farmerName.isEmpty
        ? ''
        : farmerName[0].toUpperCase() + farmerName.substring(1);

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 165, 255, 137),
              child: Text(
                formattedFarmerName.isNotEmpty ? formattedFarmerName[0] : '',
                style: const TextStyle(fontSize: 30.0, color: Colors.blue),
              ),
            ),
            accountName: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                formattedFarmerName,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            accountEmail: Text(
              farmerEmail,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          DrawerListTile(
            leadingIcon: Icons.person,
            title: 'strMyProfile'.tr,
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.myProfile);
            },
          ),
          DrawerListTile(
            leadingIcon: Icons.history,
            title: 'strMyOrders'.tr,
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.myOrder);
            },
          ),
          DrawerListTile(
            leadingIcon: Icons.language,
            title: 'strChangeLanguage'.tr,
            onTap: () => buildLanguageDialog(context),
          ),
          DrawerListTile(
            leadingIcon: Icons.headset_mic,
            title: 'strAboutUs'.tr,
            onTap: () {
              Get.toNamed(AppRoutes.aboutUs);
            },
          ),
          DrawerListTile(
            leadingIcon: Icons.feedback,
            title: 'strFeedback'.tr,
            onTap: () => openUrl(
                'https://airtable.com/app6wXf11QqIxHmLr/shryuALS7CvZ3yzpU'),
          ),
          DrawerListTile(
            leadingIcon: Icons.logout,
            color: Colors.red,
            title: 'strLogOut'.tr,
            onTap: () {
              _auth.signOut().then((value) {
                Get.offAllNamed(AppRoutes.login);
              }).then((value) {
                orderController.clearData();
              }).onError((error, stackTrace) {
                showToast(title: error.toString());
              });
            },
          ),
        ],
      ),
    );
  }
}
