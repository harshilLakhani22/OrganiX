import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/utils/constants/sizes.dart';

import '../../../../domain/auth_methods.dart';

class MForgotPassword extends StatelessWidget {
  const MForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => openForgetPasswordBottomSheet(),
        child: Text(
          'strForgotPassword'.tr,
          style: const TextStyle(
            decoration: TextDecoration.underline,
            fontSize: MSizes.md,
          ),
        ),
      ),
    );
  }
}
