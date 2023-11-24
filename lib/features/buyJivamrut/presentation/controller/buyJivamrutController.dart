import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organix/features/myOrder/presentation/controller/my_order_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../myOrder/data/model/order_model.dart';

class BuyJivamrutController extends GetxController{

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final GetStorage box = GetStorage();
  final OrderController orderController = Get.find<OrderController>();
  final Uuid _uuid = Uuid();


  @override
  void onInit() {
    super.onInit();
    nameController.text = box.read('farmerName');
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController addLine1Controller = TextEditingController();
  TextEditingController addLine2Controller = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController villageController = TextEditingController();


  // void addToHistory() async {
  //   String name = nameController.text.trim();
  //   String mobile = mobileController.text.trim();
  //   String quantity = quantityController.text.trim();
  //   String addLine1 = addLine1Controller.text.trim();
  //   String addLine2 = addLine2Controller.text.trim();
  //   String pincode = pincodeController.text.trim();
  //   String village = villageController.text.trim();
  //
  //   if (name != "" &&
  //       mobile != "" &&
  //       quantity != "" &&
  //       addLine1 != "" &&
  //       addLine2 != "" &&
  //       pincode != "" &&
  //       village != "") {
  //
  //     // Check if the user is logged in
  //     if (FirebaseAuth.instance.currentUser != null) {
  //       String uid = FirebaseAuth.instance.currentUser!.uid;
  //
  //       // Find the document in the "userInfo" collection based on the UID
  //       DocumentSnapshot userInfoDocument = await _firebaseFirestore
  //           .collection("userInfo")
  //           .doc(uid)
  //           .get();
  //
  //       // Check if a document was found
  //       if (userInfoDocument.exists) {
  //         // Get the current value of the "history" field (if it exists)
  //         Map<String, dynamic> data = userInfoDocument.data() as Map<String, dynamic>;
  //         List<dynamic> history = data["history"] ?? [];
  //
  //         // Add the new order data to the "history" field
  //         history.add({
  //           "name": name,
  //           "mobile": mobile,
  //           "quantity": quantity,
  //           "addLine1": addLine1,
  //           "addLine2": addLine2,
  //           "pincode": pincode,
  //           "village": village,
  //           "isAcceptedFromAdmin": false,
  //           "isCancelFromFarmer": false,
  //           "isCurrentOrder": true,
  //           "orderDate": DateTime.now(),
  //         });
  //
  //         // Update the "history" field in the document
  //         await _firebaseFirestore
  //             .collection("userInfo")
  //             .doc(uid)
  //             .update({"history": history});
  //
  //         nameController.clear();
  //         mobileController.clear();
  //         quantityController.clear();
  //         addLine1Controller.clear();
  //         addLine2Controller.clear();
  //         pincodeController.clear();
  //         villageController.clear();
  //         debugPrint("Order Placed");
  //       } else {
  //         debugPrint("User information not found");
  //         // Handle the case where user information is not found
  //       }
  //     } else {
  //       debugPrint("User not logged in");
  //       // Handle the case where the user is not logged in
  //     }
  //   }
  // }

  void addToHistory() async {
    String name = nameController.text.trim();
    String mobile = mobileController.text.trim();
    String quantity = quantityController.text.trim();
    String addLine1 = addLine1Controller.text.trim();
    String addLine2 = addLine2Controller.text.trim();
    String pincode = pincodeController.text.trim();
    String village = villageController.text.trim();

    if (name.isNotEmpty &&
        mobile.isNotEmpty &&
        quantity.isNotEmpty &&
        addLine1.isNotEmpty &&
        addLine2.isNotEmpty &&
        pincode.isNotEmpty &&
        village.isNotEmpty) {
      // Check if the user is logged in
      if (FirebaseAuth.instance.currentUser != null) {
        String uid = FirebaseAuth.instance.currentUser!.uid;

        // Find the document in the "userInfo" collection based on the UID
        DocumentSnapshot userInfoDocument = await _firebaseFirestore
            .collection("userInfo")
            .doc(uid)
            .get();

        // Check if a document was found
        if (userInfoDocument.exists) {
          // Get the current value of the "history" field (if it exists)
          Map<String, dynamic> data = userInfoDocument.data() as Map<String, dynamic>;
          List<dynamic> history = data["history"] ?? [];
          String orderId = _uuid.v4();


          // Add the new order data to the "history" field
          history.add({
            "orderId": orderId,  // Add orderId to the order data
            "name": name,
            "mobile": mobile,
            "quantity": quantity,
            "addLine1": addLine1,
            "addLine2": addLine2,
            "pincode": pincode,
            "village": village,
            "isAcceptedFromAdmin": false,
            "isCancelFromFarmer": false,
            "isCurrentOrder": true,
            "orderDate": DateTime.now(),
          });

          // Update the "history" field in the document
          await _firebaseFirestore
              .collection("userInfo")
              .doc(uid)
              .update({"history": history});

          nameController.clear();
          mobileController.clear();
          quantityController.clear();
          addLine1Controller.clear();
          addLine2Controller.clear();
          pincodeController.clear();
          villageController.clear();

          // Now, call the addOrder method from OrderController
          Get.find<OrderController>().addOrder(OrderModel(
            orderId: orderId,
            quantity: quantity,
            orderDate: DateTime.now(),
            isAcceptedFromAdmin: false,
            isCurrentOrder: true,
            isCancelFromFarmer: false,
          ));
        } else {
          // Handle the case where user information is not found
        }
      } else {
        // Handle the case where the user is not logged in
      }
    }
  }


  String? getUserEmail() {
    return box.read('farmerEmail') ?? "AA";
  }

  String getTrimmedText(TextEditingController controller) {
    return controller.text.trim();
  }

  void clearControllers(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      controller.clear();
    }
  }

  bool isNotEmpty(String text) {
    return text.isNotEmpty;
  }

}