import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organix/core/methods/methods.dart';
import 'package:organix/core/presentation/widgets/rounded_button.dart';
import 'package:organix/core/utils/constants/colors.dart';
import 'package:organix/core/utils/constants/sizes.dart';
import 'package:organix/features/auth/presentation/controller/auth_controller.dart';
import 'package:organix/features/auth/presentation/pages/login/widgets/forgot_password.dart';
import 'package:organix/features/auth/presentation/pages/login/widgets/login_header.dart';
import 'package:organix/features/auth/presentation/pages/login/widgets/login_text_fields.dart';
import 'package:organix/features/myOrder/presentation/controller/buy_order_page_controller.dart';
import 'package:organix/routes/app_routes.dart';

import '../../../../../core/common/widgets/appbar/auth_appbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final BuyOrderController orderController = Get.put(BuyOrderController());
  bool loading = false;
  String uid = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final authController = Get.put(AuthController());
  User? user;

  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MAuthAppBar(title: 'strLogYouIn',),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          padding: const EdgeInsets.symmetric(horizontal: MSizes.lg),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Logo, Title & sub-Title
              const MLoginHeader(),

              /// Login Form
              Column(
                children: [
                  MLoginTextFields(
                      formKey: _formKey,
                      emailController: emailController,
                      passwordController: passwordController,
                      authController: authController),

                  /// Forgot Password
                  const MForgotPassword(),
                  const SizedBox(height: MSizes.spaceBtwSections),

                  /// Login Button
                  RoundButton(
                    title: "strLogin".tr,
                    isLoading: loading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                  ),
                  const SizedBox(height: MSizes.spaceBtwItems),
                ],
              ),

              /// Go to SignUp
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("strDontHaveAcc".tr),
                  TextButton(
                    onPressed: () {
                      // clearController();
                      Get.offAllNamed(AppRoutes.signUp);
                    },
                    child: Text(
                      "strSignUp".tr,
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          fontSize: MSizes.md),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MSizes.spaceBtwItems),

              /// Login With Mobile Number
              InkWell(
                onTap: () {
                  clearController();
                  Get.toNamed(AppRoutes.loginWithMobile);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(),
                  ),
                  child: Center(
                    child: Text(
                      "strLoginWithMobileNum".tr,
                      style: const TextStyle(
                          color: MColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: MSizes.md),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    setState(() {
      loading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );

      user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userSnapshot = await _firebaseFirestore
            .collection("userInfo")
            .doc(user!.uid)
            .get();

        if (userSnapshot.exists) {
          String userName = userSnapshot['userName'];
          String userEmail = userSnapshot['email'];
          box.write('farmerName', userName);
          box.write('farmerEmail', userEmail);
          print("Login farmerName $userName");
          print("Login farmerEmail $userEmail");
        }
      }
      setState(() {
        uid = user!.uid;
        loading = false;
      });

      box.write('uid', uid);
      print("Login uid $uid");

      orderController.fetchCurrentOrders();
      FocusScope.of(context).unfocus();
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.toNamed(AppRoutes.dashboard);
      });
    } catch (error) {
      showToast(title: error.toString());
      setState(() {
        loading = false;
      });
    }
  }

  String? getUserEmail() {
    return box.read('farmerEmail') ?? "AA";
  }

  // Future<QuerySnapshot> getUserInfo(String eMail) async {
  //   return await _firebaseFirestore
  //       .collection("userInfo")
  //       .where("email", isEqualTo: eMail)
  //       .get();
  // }
  // searchUser(String eMail) async {
  //   QuerySnapshot querySnapshot = await getUserInfo(eMail);
  //   String queryFarmerName = querySnapshot.docs[0]['userName'];
  //   String queryFarmerEmail = querySnapshot.docs[0]['email'];
  //   box.write('farmerName', queryFarmerName);
  //   box.write('farmerEmail', queryFarmerEmail);
  // }

  void clearController() {
    emailController.clear();
    passwordController.clear();
  }
}
