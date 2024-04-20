import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:organix/core/common/widgets/appbar/auth_appbar.dart';
import 'package:organix/core/methods/methods.dart';
import 'package:organix/core/presentation/widgets/text_fields/custom_textField.dart';
import 'package:organix/core/presentation/widgets/rounded_button.dart';
import 'package:organix/routes/app_routes.dart';

import '../../../../../core/utils/constants/sizes.dart';
import '../../controller/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool loading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final authController = Get.put(AuthController());
  GetStorage box = GetStorage();

  late User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MAuthAppBar(title: "strSignYouUp"),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: MSizes.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// SignUp Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        hintText: "strEnterName".tr,
                        prefixIcon: Icons.person,
                        validationMessage: "strEnterName".tr,
                      ),
                      const SizedBox(height: MSizes.spaceBtwInputFields),
                      CustomTextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "strEnterEmail".tr,
                        prefixIcon: Icons.email_sharp,
                        validationMessage: "strEnterEmail".tr,
                      ),
                      const SizedBox(height: MSizes.spaceBtwInputFields),
                      Obx(
                        () => CustomTextField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          hintText: "strEnterPassword".tr,
                          prefixIcon: Icons.lock,
                          validationMessage: "strEnterPassword".tr,
                          isObscureText: authController.isPasswordHidden.value,
                          // suffixIcon: authController.isPasswordHidden.value
                          //     ? Icons.visibility
                          //     : Icons.visibility_off,
                          onTap: () {
                            authController.isPasswordHidden.value =
                                !authController.isPasswordHidden.value;
                          },
                        ),
                      ),
                      const SizedBox(height: MSizes.spaceBtwInputFields),
                      Obx(
                        () => CustomTextField(
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.text,
                          hintText: "strConfirmPassword".tr,
                          prefixIcon: Icons.lock_open,
                          validationMessage: "strEnterPassword".tr,
                          isObscureText: authController.isPasswordHidden.value,
                          suffixIcon: authController.isPasswordHidden.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onTap: () {
                            authController.isPasswordHidden.value =
                                !authController.isPasswordHidden.value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: MSizes.spaceBtwSections * 1.5),

                /// SignUp Button
                RoundButton(
                  title: "strSignUp".tr,
                  isLoading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      singUp();
                    }
                  },
                ),
                const SizedBox(height: MSizes.spaceBtwSections),

                /// Go to LogIn
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("strAlreadyHaveAcc".tr),
                    TextButton(
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.login);
                      },
                      child: Text(
                        "strLogin".tr,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          fontSize: MSizes.md
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void singUp() async {
    setState(() {
      loading = true;
    });
    if (passwordController.text.toString() !=
        confirmPasswordController.text.toString()) {
      showToast(title: "strPasswordMatch".tr);
      return;
    }
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );

      user = _auth.currentUser;
      if (user != null) {
        // Store uid, email, and userName in "userInfo" collection
        await _firebaseFirestore.collection("userInfo").doc(user!.uid).set({
          "uid": user!.uid,
          "email": user!.email,
          "userName": nameController.text.toString(),
        });
      }

      box.write('farmerName', nameController.text.toString());
      box.write('farmerEmail', emailController.text.toString());
      box.write('uid', user!.uid); // Store uid in GetStorage

      setState(() {
        loading = false;
      });
      Get.offNamed(AppRoutes.dashboard);
    } catch (error) {
      showToast(title: error.toString());
      setState(() {
        loading = false;
      });
    }
  }
}
