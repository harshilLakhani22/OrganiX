import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organix/core/methods/methods.dart';
import 'package:organix/core/presentation/widgets/custom_textField.dart';
import 'package:organix/core/presentation/widgets/rounded_button.dart';
import 'package:organix/features/auth/domain/auth_methods.dart';
import 'package:organix/features/auth/presentation/controller/auth_controller.dart';
import 'package:organix/features/splashScreen/presentation/pages/splash_page.dart';
import 'package:organix/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  String uid = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final authController = Get.put(AuthController());
   User? user;

  GetStorage box = GetStorage();

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
        // Fetch user data from the "userInfo" collection using uid
        DocumentSnapshot userSnapshot = await _firebaseFirestore
            .collection("userInfo")
            .doc(user!.uid)
            .get();

        // Check if the document exists
        if (userSnapshot.exists) {
          // If the document exists, update the local data
          String userName = userSnapshot['userName'];
          String userEmail = userSnapshot['email'];

          box.write('farmerName', userName);
          box.write('farmerEmail', userEmail);

        }
      }

      setState(() {
        uid = user!.uid;
        loading = false;
      });

      box.write('uid', uid);

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

  String? getUserEmail() {
    // Replace with your actual key used for storing the user's email in GetStorage
    return box.read('farmerEmail') ?? "AA";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("strLogin".tr),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // Align vertically in the center
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "strEnterEmail".tr,
                      prefixIcon: Icons.email_sharp,
                      validationMessage: "strEnterEmail".tr,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => CustomTextField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        hintText: "strEnterPassword".tr,
                        prefixIcon: Icons.lock_open,
                        validationMessage: "strEnterPassword".tr,
                        isObscureText: authController.isPasswordHidden.value,
                        suffixIcon: authController.isPasswordHidden.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onTap: () {
                          authController.isPasswordHidden.value =
                              !authController.isPasswordHidden.value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => openForgetPasswordBottomSheet(),
                  child: Text(
                    'strForgotPassword'.tr,
                    style:
                        const TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              RoundButton(
                title: "strLogin".tr,
                isLoading: loading,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("strDontHaveAcc".tr),
                  TextButton(
                    onPressed: () {
                      clearController();
                      Get.offAllNamed(AppRoutes.signUp);
                    },
                    child: Text(
                      "strSignUp".tr,
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
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
                        color: Color(0xff598216),
                        fontWeight: FontWeight.w500,
                      ),
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

  void clearController() {
    emailController.clear();
    passwordController.clear();
  }
}
