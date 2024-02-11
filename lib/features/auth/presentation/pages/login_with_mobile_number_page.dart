import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/methods/methods.dart';
import 'package:organix/core/presentation/widgets/rounded_button.dart';
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

  void loginWithMobi() {
    phoneNumberController.text = frontPhoneNum.text.toString() + backPhoneNum.text.toString();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("strLoginWithMobileNum".tr),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
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
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: RoundButton(
                  isLoading: loading,
                  title: "strSendTheCode".tr,
                  onTap: loginWithMobi,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
