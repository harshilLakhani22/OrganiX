
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/presentation/widgets/text_fields/custom_textField.dart';
import '../../../../../../core/utils/constants/sizes.dart';
import '../../../controller/auth_controller.dart';

class MLoginTextFields extends StatelessWidget {
  const MLoginTextFields({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
    required this.authController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// Email
          CustomTextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: "strEnterEmail".tr,
            prefixIcon: Icons.email_sharp,
            validationMessage: "strEnterEmail".tr,
          ),
          const SizedBox(height: MSizes.spaceBtwInputFields),

          /// Password
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
    );
  }
}
