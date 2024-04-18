import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/common/widgets/appbar/auth_appbar.dart';
import 'package:organix/core/presentation/widgets/custom_textField.dart';
import 'package:organix/core/presentation/widgets/rounded_button.dart';
import 'package:organix/core/utils/constants/sizes.dart';
import 'package:organix/features/auth/presentation/controller/auth_controller.dart';
import 'package:organix/features/myProfile/presentation/controller/myProfileController.dart';
import 'package:organix/features/myProfile/presentation/widgets/profilePhoto.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({super.key});

  final MyProfileController myProfileController =
      Get.put(MyProfileController());
  final AuthController authController = Get.put(AuthController());

  // final MyProfileController myProfileController = Get.find<MyProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color(0xffe6f6f0),
      appBar: const MAuthAppBar(title: 'strMyProfile',),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                InkWell(
                  child: const ProfilePhoto(),
                  onTap: () async {
                    await myProfileController.pickProfilePhoto();
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  myProfileController.farmerName != null
                      ? myProfileController.farmerName![0].toUpperCase() +
                          myProfileController.farmerName!.substring(1)
                      : 'Default Value',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: myProfileController.nameController,
                  keyboardType: TextInputType.name,
                  hintText: "strEnterName".tr,
                  prefixIcon: Icons.person,
                  validationMessage: "strEnterName".tr,
                  suffixIcon: Icons.edit,
                ),
                const SizedBox(height: MSizes.spaceBtwInputFields),
                CustomTextField(
                  controller: myProfileController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "strEnterEmail".tr,
                  prefixIcon: Icons.email_sharp,
                  validationMessage: "strEnterEmail".tr,
                  readOnly: true,
                  // onTap: null,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                    child: RoundButton(
                  isBorder: true,
                  title: "Cancel",
                  buttonColor: Colors.transparent,
                  onTap: () => Get.back(),
                  textColor: Colors.black87,
                )),
                const SizedBox(width: MSizes.spaceBtwSections),
                Expanded(
                  child: RoundButton(
                    // buttonColor: Color(0xff1C1E23),
                    title: "Edit",
                    onTap: () {
                      myProfileController.editName(
                          myProfileController.nameController.text.trim());
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
