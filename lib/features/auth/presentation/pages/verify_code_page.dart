import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organix/core/presentation/widgets/rounded_button.dart';
import 'package:organix/routes/app_routes.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/methods/methods.dart';

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

    }  catch (e) {
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
      appBar: AppBar(
        title: Text("strLoginWithMobileNum".tr),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/loginWithMobile.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "strPhoneVerification".tr,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "strRegPhoneNum".tr,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                showCursor: true,
                onChanged: (value){
                  verificationCodeController.text = value;
                  // otpCode = value;
                },
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: RoundButton(
                  isLoading: loading,
                  title: "strVerifyPhoneNumber".tr,
                  onTap: verifyOtp,
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "strEditPhoneNum".tr,
                        style: const TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
