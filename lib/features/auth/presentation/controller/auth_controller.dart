import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/widgets/common_textfield.dart';

class AuthController extends GetxController{
  RxBool isPasswordHidden = true.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;



  TextEditingController forgotPasswordController = TextEditingController();

  void sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      Get.back();
      Get.snackbar("Password reset email link is sent in your email", "Success");
    }).catchError((onError) => Get.snackbar("Error in Email Reset", "Failure"));
  }
}