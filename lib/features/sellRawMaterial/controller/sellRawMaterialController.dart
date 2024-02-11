import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organix/features/myOrder/data/model/sell_order_model.dart';
import 'package:uuid/uuid.dart';

class SellRawMaterialController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final GetStorage box = GetStorage();
  final Uuid _uuid = Uuid();

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController addLine1Controller = TextEditingController();
  TextEditingController addLine2Controller = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  String rawMaterialType = 'strAnimalDung'.tr; // Default value

  void setRawMaterialType(String type) {
    rawMaterialType = type;
    update(); // Update the UI to reflect the selected type
  }

  void addToSellHistory() async {
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
      String uid = box.read('uid') ?? "";
      print(box.read('uid'));

      final userInfoDocument =
          await _firebaseFirestore.collection("userInfo").doc(uid);

      String orderId = _uuid.v4();

      final order = SellOrderModel(
        orderId: orderId,
        quantity: quantity,
        orderDate: DateTime.now(),
        rawMaterialType: rawMaterialType,
        addLine1: addLine1,
        addLine2: addLine2,
        mobile: mobile,
        name: name,
        village: village,
        pincode: pincode,
        isAcceptedFromAdmin: false,
        isCurrentOrder: true,
        isCancelFromFarmer: false,
      );

      await userInfoDocument.update({
        "sellHistory": FieldValue.arrayUnion([order.toJson()])
      });

      nameController.clear();
      mobileController.clear();
      quantityController.clear();
      addLine1Controller.clear();
      addLine2Controller.clear();
      pincodeController.clear();
      villageController.clear();

      print("Sell Order Placed");
    }
  }
}
