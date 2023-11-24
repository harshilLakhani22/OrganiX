import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organix/core/methods/methods.dart';
import 'package:organix/core/presentation/widgets/custom_textField.dart';
import 'package:organix/features/buyJivamrut/presentation/controller/buyJivamrutController.dart';
import 'package:organix/features/myOrder/presentation/controller/my_order_controller.dart';

class BuyJivamrutScreen extends StatefulWidget {
  const BuyJivamrutScreen({super.key});


  @override
  State<BuyJivamrutScreen> createState() => _BuyJivamrutScreenState();
}

class _BuyJivamrutScreenState extends State<BuyJivamrutScreen> {

  final _formKey = GlobalKey<FormState>();
  // final BuyJivamrutController buyJivamrutController = Get.put(BuyJivamrutController());

  final BuyJivamrutController buyJivamrutController = Get.find<BuyJivamrutController>();


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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: buyJivamrutController.nameController,
                    keyboardType: TextInputType.name,
                    hintText: "strEnterName".tr,
                    prefixIcon: Icons.person,
                    validationMessage: "strEnterName".tr,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: buyJivamrutController.mobileController,
                    keyboardType: TextInputType.number,
                    hintText: "strMobileNumber".tr,
                    prefixIcon: Icons.phone,
                    validationMessage: "strMobileNumber".tr,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: buyJivamrutController.quantityController,
                    keyboardType: TextInputType.number,
                    hintText: "strQuantity".tr,
                    prefixIcon: Icons.ac_unit_rounded,
                    validationMessage: "strQuantity".tr,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: buyJivamrutController.addLine1Controller,
                    keyboardType: TextInputType.text,
                    hintText: "strAddressLine1".tr,
                    prefixIcon: Icons.location_on,
                    validationMessage: "strEnterAddress".tr,),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: buyJivamrutController.addLine2Controller,
                    keyboardType: TextInputType.text,
                    hintText: "strAddressLine2".tr,
                    prefixIcon: Icons.location_on,
                    validationMessage: "strEnterAddress".tr,),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: buyJivamrutController.pincodeController,
                    keyboardType: TextInputType.number,
                    hintText: "strPINCode".tr,
                    prefixIcon: Icons.pin,
                    validationMessage: "strPINCode".tr,),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(controller: buyJivamrutController.villageController,
                      keyboardType: TextInputType.text,
                      hintText: "strVillage".tr,
                      prefixIcon: Icons.location_city,
                      validationMessage: "strEnterVillage".tr,),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // buyJivamrutController.placeOrder();
                          buyJivamrutController.addToHistory();
                          Get.back();
                          // showToast(title: 'strOrderPlacedSuccessfully'.tr);
                          // orderSuccessSnackbar;
                          ScaffoldMessenger.of(context).showSnackBar(orderSuccessSnackbar);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: const Color(0xff688656)),
                      child: Text(
                        "strPlaceOrder".tr,
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
    );
  }
}
