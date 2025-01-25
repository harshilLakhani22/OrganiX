import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileController extends GetxController {
  final GetStorage box = GetStorage();
  String? profileImagePath;

  String? farmerName;
  String? farmerEmail;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobiController = TextEditingController();

  MyProfileController() {
    farmerName = box.read('farmerName');
    farmerEmail = box.read('farmerEmail');
  }

  @override
  void onInit() {
    super.onInit();
    farmerName ??= '';
    farmerEmail ??= '';
    nameController.text = box.read('farmerName');
    emailController.text = box.read('farmerEmail');
  }

  Future<void> pickProfilePhoto() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImagePath = pickedFile.path; // Store the picked image path
      update(); // Notify listeners that the state has changed
      print("Image picked: ${pickedFile.path}");
    } else {
      print("No image picked.");
    }
  }
  void editName(String name) async {
    String userUid = box.read("uid");
    var userInfoDoc =
    FirebaseFirestore.instance.collection('userInfo').doc(userUid);
    await userInfoDoc.update({
      'userName' : name,
    });
    box.write('farmerName', name);
    print(box.read('farmerName'));
  }
}
