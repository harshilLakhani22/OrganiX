import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/common/widgets/appbar/auth_appbar.dart';
import 'package:organix/core/presentation/widgets/text_fields/custom_textField.dart';
import 'package:organix/core/utils/constants/colors.dart';
import 'package:organix/core/utils/constants/sizes.dart';
import 'package:organix/features/buyJivamrut/presentation/controller/buyJivamrutController.dart';

class BuyJivamrutScreen extends StatefulWidget {
  const BuyJivamrutScreen({super.key});

  @override
  State<BuyJivamrutScreen> createState() => _BuyJivamrutScreenState();
}

class _BuyJivamrutScreenState extends State<BuyJivamrutScreen> {
  final _formKey = GlobalKey<FormState>();

  // final BuyJivamrutController buyJivamrutController = Get.put(BuyJivamrutController());
  final BuyJivamrutController buyJivamrutController =
      Get.find<BuyJivamrutController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        appBar: const MAuthAppBar(
          title: 'strBuyJivamrut',
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: MSizes.spaceBtwInputFields),
                  CustomTextField(
                    controller: buyJivamrutController.nameController,
                    keyboardType: TextInputType.name,
                    hintText: "strEnterName".tr,
                    prefixIcon: Icons.person,
                    validationMessage: "strEnterName".tr,
                  ),
                  const SizedBox(height: MSizes.spaceBtwInputFields),
                  CustomTextField(
                    controller: buyJivamrutController.mobileController,
                    keyboardType: TextInputType.number,
                    hintText: "strMobileNumber".tr,
                    prefixIcon: Icons.phone,
                    validationMessage: "strMobileNumber".tr,
                  ),
                  const SizedBox(height: MSizes.spaceBtwInputFields),
                  CustomTextField(
                    controller: buyJivamrutController.quantityController,
                    keyboardType: TextInputType.number,
                    hintText: "strQuantity".tr,
                    prefixIcon: Icons.ac_unit_rounded,
                    validationMessage: "strQuantity".tr,
                  ),
                  const SizedBox(height: MSizes.spaceBtwInputFields),
                  CustomTextField(
                    controller: buyJivamrutController.addLine1Controller,
                    keyboardType: TextInputType.text,
                    hintText: "strAddressLine1".tr,
                    prefixIcon: Icons.location_on,
                    validationMessage: "strEnterAddress".tr,
                  ),
                  const SizedBox(height: MSizes.spaceBtwInputFields),
                  CustomTextField(
                    controller: buyJivamrutController.addLine2Controller,
                    keyboardType: TextInputType.text,
                    hintText: "strAddressLine2".tr,
                    prefixIcon: Icons.location_on,
                    validationMessage: "strEnterAddress".tr,
                  ),
                  const SizedBox(height: MSizes.spaceBtwInputFields),
                  CustomTextField(
                    controller: buyJivamrutController.pincodeController,
                    keyboardType: TextInputType.number,
                    hintText: "strPINCode".tr,
                    prefixIcon: Icons.pin,
                    validationMessage: "strPINCode".tr,
                  ),
                  const SizedBox(height: MSizes.spaceBtwInputFields),
                  CustomTextField(
                    controller: buyJivamrutController.villageController,
                    keyboardType: TextInputType.text,
                    hintText: "strVillage".tr,
                    prefixIcon: Icons.location_city,
                    validationMessage: "strEnterVillage".tr,
                  ),
                  const SizedBox(height: MSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          buyJivamrutController.addToBuyHistory();
                          Get.back();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: MColors.accent,
                      ),
                      child: Text(
                        "strPlaceOrder".tr,
                        style: const TextStyle(fontSize: MSizes.mdlg, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
