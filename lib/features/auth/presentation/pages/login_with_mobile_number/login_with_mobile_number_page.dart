import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/common/widgets/appbar/auth_appbar.dart';
import 'package:organix/core/methods/methods.dart';
import 'package:organix/core/presentation/widgets/rounded_button.dart';
import 'package:organix/core/utils/constants/colors.dart';
import 'package:organix/core/utils/constants/image_strings.dart';
import 'package:organix/core/utils/constants/sizes.dart';
import 'package:organix/features/auth/presentation/pages/verify_code_page.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNumberController = TextEditingController();
  final frontPhoneNum = TextEditingController();
  final backPhoneNum = TextEditingController();
  bool loading = false;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    frontPhoneNum.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MAuthAppBar(
        title: 'strLoginWithMobileNum',
        showBackArrow: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Image Header
              const Image(
                image: AssetImage(MImages.imgLoginWithMobile),
                width: 250,
                height: 250,
              ),
              const SizedBox(height: MSizes.spaceBtwSections),
              Text(
                "strPhoneVerification".tr,
                style: const TextStyle(
                  fontSize: MSizes.lg,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: MSizes.spaceBtwItems),
              Text(
                "strRegPhoneNum".tr,
                style: const TextStyle(
                  fontSize: MSizes.md,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MSizes.spaceBtwSections),

              /// Mobile Number Input
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: MColors.darkerGrey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: MSizes.smmd,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: frontPhoneNum,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      controller: backPhoneNum,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "strPhone".tr,
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(height: MSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RoundButton(
                  isLoading: loading,
                  title: "strSendTheCode".tr,
                  onTap: loginWithMobile,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginWithMobile() {
    phoneNumberController.text =
        frontPhoneNum.text.toString() + backPhoneNum.text.toString();
    setState(() {
      loading = true;
    });
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumberController.text,
      verificationCompleted: (_) {
        setState(() {
          loading = false;
        });
      },
      verificationFailed: (e) {
        setState(() {
          loading = false;
        });
        showToast(title: e.toString());
      },
      codeSent: (verificationId, token) {
        setState(() {
          loading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyCodeScreen(
              verificationId: verificationId,
            ),
          ),
        );
        // Get.toNamed(AppRoutes.verifyCodeScreen, arguments: verificationId);
      },
      codeAutoRetrievalTimeout: (e) {
        showToast(title: e.toString());
        setState(() {
          loading = false;
        });
      },
    );
  }
}
