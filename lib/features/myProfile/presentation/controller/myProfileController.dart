import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyProfileController extends GetxController {
  final GetStorage box = GetStorage();

  String? farmerName;
  String? farmerEmail;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobiController = TextEditingController();

  MyProfileController() {
    // Initialize values in the constructor or another method
    farmerName = box.read('farmerName');
    farmerEmail = box.read('farmerEmail');
  }

  @override
  void onInit() {
    super.onInit();
    // Accessing the values and assigning defaults if null
    farmerName ??= '';
    farmerEmail ??= '';
    nameController.text = box.read('farmerName');
    emailController.text = box.read('farmerEmail');
  }
}
