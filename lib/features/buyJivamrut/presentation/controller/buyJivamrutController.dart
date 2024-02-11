import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organix/core/methods/methods.dart';
import 'package:organix/features/myOrder/presentation/controller/buy_order_page_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../myOrder/data/model/buy_order_model.dart';

class BuyJivamrutController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final GetStorage box = GetStorage();
  final BuyOrderController orderController = Get.find<BuyOrderController>();
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


  void addToBuyHistory() async {
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
      if (int.tryParse(quantity) != null) {
        int orderQuantity = int.parse(quantity);

        if (orderQuantity > 100) {
          // Show a dialog box indicating that the user cannot order more than 100 kg
          Get.dialog(
            AlertDialog(
              title: Text('Quantity Limit Exceeded'),
              content: Text('You cannot order more than 100 kg.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
          return; // Exit the method if the quantity exceeds the limit
        }
      }

      if (FirebaseAuth.instance.currentUser != null) {
        String uid = FirebaseAuth.instance.currentUser!.uid;

        final userInfoDocument =
            await _firebaseFirestore.collection("userInfo").doc(uid);

        String orderId = _uuid.v4();

        final order = BuyOrderModel(
          orderId: orderId,
          quantity: quantity,
          orderDate: DateTime.now(),
          isAcceptedFromAdmin: false,
          isCurrentOrder: true,
          isCancelFromFarmer: false,
          addLine1: addLine1,
          addLine2: addLine2,
          mobile: mobile,
          name: name,
          village: village,
          pincode: pincode,
        );

        await userInfoDocument.update({
          "history": FieldValue.arrayUnion([order.toJson()])
        });

        mobileController.clear();
        quantityController.clear();
        addLine1Controller.clear();
        addLine2Controller.clear();
        pincodeController.clear();
        villageController.clear();

        Get.find<BuyOrderController>().addOrder(order);
        showToast(title: "Order Placed SuccessFully");
        print("Order Placed");
      } else {

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
