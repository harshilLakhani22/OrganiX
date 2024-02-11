import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organix/core/presentation/widgets/custom_textField.dart';
import 'package:organix/features/sellRawMaterial/controller/sellRawMaterialController.dart';
import 'package:organix/features/sellRawMaterial/presentation/widgets/sell_dropdown_widget.dart';

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
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: sellRawMaterialController.mobileController,
                      keyboardType: TextInputType.number,
                      hintText: "strMobileNumber".tr,
                      validationMessage: "strMobileNumber".tr,
                      prefixIcon: Icons.phone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: const DropDownMenuWidget(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(controller: sellRawMaterialController
                        .quantityController,
                        keyboardType: TextInputType.number,
                        hintText: "strQuantity".tr,
                        validationMessage: "strQuantity".tr,
                      prefixIcon: Icons.ac_unit_rounded,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(controller: sellRawMaterialController
                        .addLine1Controller,
                      keyboardType: TextInputType.text,
                      hintText: "strAddressLine1".tr,
                      validationMessage: "strEnterAddress".tr,
                      prefixIcon: Icons.location_on,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(controller: sellRawMaterialController
                        .addLine2Controller,
                      keyboardType: TextInputType.text,
                      hintText: "strAddressLine2".tr,
                      validationMessage: "strEnterAddress".tr,
                      prefixIcon: Icons.location_on,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(controller: sellRawMaterialController
                        .pincodeController,
                      keyboardType: TextInputType.number,
                      hintText: "strPINCode".tr,
                      validationMessage: "strPINCode".tr,
                      prefixIcon: Icons.pin,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(controller: sellRawMaterialController
                        .villageController,
                      keyboardType: TextInputType.text,
                      hintText: "strVillage".tr,
                      validationMessage: "strEnterVillage".tr,
                      prefixIcon: Icons.location_city,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            sellRawMaterialController.addToSellHistory();
                            Get.back();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: const Color(0xff688656)),
                        child: Text(
                          "strSellMaterial".tr,
                          style: const TextStyle(fontSize: 20),
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
