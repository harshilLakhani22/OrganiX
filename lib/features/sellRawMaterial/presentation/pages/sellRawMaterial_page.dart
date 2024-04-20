import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/presentation/widgets/text_fields/custom_textField.dart';
import 'package:organix/core/utils/constants/sizes.dart';
import 'package:organix/features/sellRawMaterial/controller/sellRawMaterialController.dart';
import 'package:organix/features/sellRawMaterial/presentation/widgets/sell_dropdown_widget.dart';

import '../../../../core/utils/constants/colors.dart';

class SellRawMaterialScreen extends StatefulWidget {
  const SellRawMaterialScreen({super.key});

  @override
  State<SellRawMaterialScreen> createState() => _SellRawMaterialScreenState();
}

class _SellRawMaterialScreenState extends State<SellRawMaterialScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final SellRawMaterialController sellRawMaterialController =
      Get.put(SellRawMaterialController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("strOrganiX".tr),
          backgroundColor: const Color(0xff598216),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: sellRawMaterialController.nameController,
                      keyboardType: TextInputType.name,
                      hintText: "strEnterName".tr,
                      validationMessage: "strEnterName".tr,
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: MSizes.spaceBtwInputFields),
                    CustomTextField(
                      controller: sellRawMaterialController.mobileController,
                      keyboardType: TextInputType.number,
                      hintText: "strMobileNumber".tr,
                      validationMessage: "strMobileNumber".tr,
                      prefixIcon: Icons.phone,
                    ),
                    const SizedBox(height: MSizes.spaceBtwInputFields),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: SellDropDownMenu(controller : sellRawMaterialController),
                    ),

                    const SizedBox(height: MSizes.spaceBtwInputFields),
                    CustomTextField(
                      controller: sellRawMaterialController.quantityController,
                      keyboardType: TextInputType.number,
                      hintText: "strQuantity".tr,
                      validationMessage: "strQuantity".tr,
                      prefixIcon: Icons.ac_unit_rounded,
                    ),
                    const SizedBox(height: MSizes.spaceBtwInputFields),
                    CustomTextField(
                      controller: sellRawMaterialController.addLine1Controller,
                      keyboardType: TextInputType.text,
                      hintText: "strAddressLine1".tr,
                      validationMessage: "strEnterAddress".tr,
                      prefixIcon: Icons.location_on,
                    ),
                    const SizedBox(height: MSizes.spaceBtwInputFields),
                    CustomTextField(
                      controller: sellRawMaterialController.addLine2Controller,
                      keyboardType: TextInputType.text,
                      hintText: "strAddressLine2".tr,
                      validationMessage: "strEnterAddress".tr,
                      prefixIcon: Icons.location_on,
                    ),
                    const SizedBox(height: MSizes.spaceBtwInputFields),
                    CustomTextField(
                      controller: sellRawMaterialController.pincodeController,
                      keyboardType: TextInputType.number,
                      hintText: "strPINCode".tr,
                      validationMessage: "strPINCode".tr,
                      prefixIcon: Icons.pin,
                    ),
                    const SizedBox(height: MSizes.spaceBtwInputFields),
                    CustomTextField(
                      controller: sellRawMaterialController.villageController,
                      keyboardType: TextInputType.text,
                      hintText: "strVillage".tr,
                      validationMessage: "strEnterVillage".tr,
                      prefixIcon: Icons.location_city,
                    ),
                    const SizedBox(height: MSizes.spaceBtwSections),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            sellRawMaterialController.addToSellHistory(sellRawMaterialController.rawMaterialType);
                            Get.back();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor:  MColors.primary,
                        ),
                        child: Text(
                          "strSellMaterial".tr,
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
      ),
    );
  }
}
