import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/presentation/widgets/cancel_button.dart';
import 'package:organix/core/presentation/widgets/custom_textField.dart';

import '../../../core/presentation/widgets/action_buttons.dart';
import '../presentation/controller/auth_controller.dart';

void openForgetPasswordBottomSheet({String? email}) {
  final authController = Get.find<AuthController>()
    ..forgotPasswordController.text = email ?? '';
  Get.bottomSheet(
    Container(
      margin: const EdgeInsets.only(top: 15, right: 25, left: 25, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CancelButton(),
          Text(
            'strForgotPassword'.tr,
            style: TextStyle(
              color: (Theme.of(Get.context!).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 12,
              bottom: 25,
            ),
            child: Text(
              'strForgotPasswordDes'.tr,
              style: const TextStyle(
                // color: Color(0xFFB9BABA),
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CustomTextField(
            controller: authController.forgotPasswordController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'strEnterEmail'.tr,
            prefixIcon: Icons.email,
            validationMessage: "strEnterPassword".tr,
          ),
          const Spacer(),
          ActionButton(
            onPressed:()=> authController.sendPasswordResetEmail(
              authController.forgotPasswordController.text,
            ),
            title: 'strSubmit'.tr,
            isLarge: true,
          ),
        ],
      ),
    ),
    backgroundColor: (Theme.of(Get.context!).brightness == Brightness.dark
        ? const Color(0xFF151513)
        : const Color(0xFFffffff)),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
  );
}
