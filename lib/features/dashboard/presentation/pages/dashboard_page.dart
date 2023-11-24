import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/features/buyJivamrut/presentation/pages/buyJivamrut_page.dart';
import 'package:organix/features/drawer/presentation/pages/drawer.dart';
import 'package:organix/features/sellRawMaterial/presentation/pages/sellRawMaterial_page.dart';
import 'package:organix/routes/app_routes.dart';

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
        title: Text("strOrganiX".tr),
        backgroundColor: const Color(0xff598216),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/output-onlinepngtools.png"),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "strGetJIVAMRUT".tr,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color(0xff688656),
                      thickness: 2,
                      endIndent: 20,
                      indent: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "strGetJivaText".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.buyJivamrut);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: const Color(0xff142814)),
                      child: Text(
                        "strBUY".tr,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/DIY-organic-soil40.png"),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "strSellRawMaterial".tr,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(
                        color: Color(0xff688656),
                        thickness: 2,
                        endIndent: 20,
                        indent: 20),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "strSellRawText".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.sellRawMaterial);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: const Color(0xff142814)),
                      child: Text(
                        "strSELL".tr,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
