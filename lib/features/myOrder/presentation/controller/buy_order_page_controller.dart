import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organix/core/methods/methods.dart';
import 'package:organix/features/myOrder/data/model/buy_order_model.dart';

import '../widgets/buy_order_widgets/buy_current_order/fail_cancel_order_dialog.dart';

class BuyOrderController extends GetxController {
  var currentOrders = <BuyOrderModel>[].obs;
  var isLoading = true.obs;
  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCurrentOrders();
  }

  String? getUserUid() {
    return box.read('uid');
  }

  void fetchCurrentOrders() async {
    try {
      isLoading(true);
      currentOrders.clear();
      var ordersFromFirestore = await fetchOrdersFromFirestore();
      currentOrders.assignAll(ordersFromFirestore);
      print("fetching orders :- $currentOrders");
    } catch (error) {
      showToast(title: 'Error fetching orders: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<List<BuyOrderModel>> fetchOrdersFromFirestore() async {
    String? userUid = getUserUid();
    print("FirestorQueryABC :- $userUid");
    print("${userUid != null}");
    if (userUid != null) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('userInfo')
          .where('uid', isEqualTo: userUid)
          .get();
      print("SDFSDF");
      if (querySnapshot.docs.isNotEmpty) {
        print("QuerySnapshot");
        print("object");
        var data = querySnapshot.docs.first.data();
        var history = data['history'] ?? [];
        List<BuyOrderModel> orders = [];
        history.forEach((orderData) {
          orders.add(BuyOrderModel(
            orderId: orderData['orderId'],
            quantity: orderData['quantity'] ?? '',
            orderDate: (orderData['orderDate'] as Timestamp).toDate(),
            isAcceptedFromAdmin: orderData['isAcceptedFromAdmin'] ?? false,
            isCurrentOrder: orderData['isCurrentOrder'] ?? true,
            isCancelFromFarmer: orderData['isCancelFromFarmer'] ?? false,
            addLine1: orderData['addLine1'],
            addLine2: orderData['addLine2'],
            mobile: orderData['mobile'],
            name: orderData['name'],
            village: orderData['village'],
            pincode: orderData['pincode'],
          ));
        });

        return orders;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }


  void cancelOrder(BuyOrderModel order) async {
    if (order.isAcceptedFromAdmin) {
      Get.dialog(const BuyFailCancelOrderDialog());
    } else {
      try {
        String? userUid = getUserUid();

        if (userUid != null) {
          var userDocRef = FirebaseFirestore.instance.collection('userInfo').doc(userUid);

          // Fetch the user document
          var userDocSnapshot = await userDocRef.get();

          if (userDocSnapshot.exists) {
            // Get the 'history' array from the user document
            var history = userDocSnapshot['history'] ?? [];

            // Find the order in the 'history' array
            var updatedHistory = history.map((orderData) {
              if (orderData['orderId'] == order.orderId) {
                // Update the 'isCancelFromFarmer' field to true
                orderData['isCancelFromFarmer'] = true;
              }
              return orderData;
            }).toList();

            // Update the 'history' array in the user document
            await userDocRef.update({'history': updatedHistory});

            // Find and remove the canceled order from the currentOrders list
            currentOrders.remove(order);

            // You might want to add some feedback to the user here
          } else {
            showToast(title: 'User document not found');
          }
        } else {
          showToast(title: 'User ID not found');
        }
      } catch (error) {
        showToast(title: 'Error canceling order: $error');
      }
    }
  }



  void addOrder(BuyOrderModel order) {
    currentOrders.add(order);
  }

  void clearData() {
    currentOrders.clear();
    isLoading(true);
  }
}
