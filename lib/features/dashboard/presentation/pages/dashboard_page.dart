import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:organix/core/utils/constants/colors.dart';
import 'package:organix/core/utils/constants/image_strings.dart';
import 'package:organix/core/utils/constants/sizes.dart';
import 'package:organix/features/drawer/presentation/pages/drawer.dart';
import 'package:organix/routes/app_routes.dart';

import '../widgets/dashboard_container.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputData();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  void inputData() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    print("cureent user id ==>${uid}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffA56622),
      drawer: DrawerScreen(),
      appBar: AppBar(
        title: Text(
          "strOrganiX".tr,
          style: const TextStyle(
            color: Colors.black,
            fontSize: MSizes.lg,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: MColors.primary,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DashBoardContainer(
            img: MImages.imgDashBoard1,
            title: "strGetJIVAMRUT",
            subTitle: 'strGetJivaText',
            onTap: () {
              Get.toNamed(AppRoutes.buyJivamrut);
            },
            buttonName: 'strBUY',
          ),
          DashBoardContainer(
            img: MImages.imgDashBoard2,
            title: 'strSellRawMaterial',
            subTitle: 'strSellRawText',
            onTap: () {
              Get.toNamed(AppRoutes.sellRawMaterial);
            },
            buttonName: "strSELL",
          ),
        ],
      ),
    );
  }
}
