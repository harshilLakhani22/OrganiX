import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organix/core/common/widgets/appbar/auth_appbar.dart';
import 'package:organix/core/presentation/widgets/rounded_button.dart';
import 'package:organix/core/utils/constants/sizes.dart';
import 'package:organix/routes/app_routes.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/methods/methods.dart';
import '../../../../core/utils/constants/image_strings.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({required this.verificationId, super.key});

  // const VerifyCodeScreen({super.key});

  final String verificationId;

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  GetStorage box = GetStorage();
  final verificationCodeController = TextEditingController();
  bool loading = false;
  final _auth = FirebaseAuth.instance;

  void verifyOtp() async {
    setState(() {
      loading = true;
    });
    final credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      // verificationId: Get.arguments['verificationId'],
      smsCode: verificationCodeController.text.toString(),
      // smsCode: otpCode,
    );
    try {
      UserCredential authResult = await _auth.signInWithCredential(credential);
      User? user = authResult.user;

      if (user != null) {
        box.write('uid', user.uid);
        box.write('farmerName', 'OrganiX User');
        await Get.offAllNamed(AppRoutes.dashboard);
      } else {
        showToast(title: "Authentication failed");
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      showToast(title: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      appBar: const MAuthAppBar(title: "strLoginWithMobileNum"),
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
                    fontSize: MSizes.lg, fontWeight: FontWeight.bold),
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

              /// Pin put
              Pinput(
                length: 6,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                showCursor: true,
                onChanged: (value) {
                  verificationCodeController.text = value;
                  // otpCode = value;
                },
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(height: MSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RoundButton(
                  isLoading: loading,
                  title: "strVerifyPhoneNumber".tr,
                  onTap: verifyOtp,
                ),
              ),
              // const SizedBox(height: MSizes.spaceBtwInputFields),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "strEditPhoneNum".tr,
                      style: const TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
