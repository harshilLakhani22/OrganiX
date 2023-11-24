import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      // controller: emailController,
                      // keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        fillColor: Colors.grey,
                        focusColor: Colors.grey,
                        hintText: "strEnterName".tr,
                        prefixIcon: const Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "strEnterName".tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "strMobileNumber".tr,
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      maxLines: 5,
                      minLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "strMobileNumber".tr;
                        }
                        return null;
                      },
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
                    TextFormField(
                      // controller: passwordController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "strQuantity".tr,
                        prefixIcon: const Icon(Icons.ac_unit_rounded),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "strQuantity".tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "strAddressLine1".tr,
                        prefixIcon: const Icon(Icons.location_on),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "strEnterAddress".tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "strAddressLine2".tr,
                        prefixIcon: const Icon(Icons.location_on),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "strEnterAddress".tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "strPINCode".tr,
                        prefixIcon: const Icon(Icons.pin),
                      ),
                      maxLines: 5,
                      minLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "strPINCode".tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "strVillage".tr,
                        prefixIcon: const Icon(Icons.location_city),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "strEnterVillage".tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          // padding: EdgeInsets.symmetric(
                          //     horizontal: 50, vertical: 15),
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
