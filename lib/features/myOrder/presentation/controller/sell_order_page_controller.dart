import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organix/core/methods/methods.dart';
import 'package:organix/features/myOrder/data/model/sell_order_model.dart';
import 'package:organix/features/myOrder/presentation/widgets/sell_order_widget/sell_current_order/sell_fail_cancel_order_dialog.dart';


class SellOrderController extends GetxController {
  var currentOrders = <SellOrderModel>[].obs;
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

  Future<List<SellOrderModel>> fetchOrdersFromFirestore() async {
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
        var sellHistory = data['sellHistory'] ?? [];
        List<SellOrderModel> orders = [];
        sellHistory.forEach((orderData) {
          orders.add(SellOrderModel(
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
            rawMaterialType: orderData['rawMaterialType'],
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

  void cancelOrder(SellOrderModel order) async {
    if (order.isAcceptedFromAdmin) {
      Get.dialog(const SellFailCancelOrderDialog());
    } else {
      try {
        // Get.dialog(const SuccessCencelOrderDialog());
        String? userUid = getUserUid();
        if (userUid != null) {
          var userInfoDoc =
          FirebaseFirestore.instance.collection('userInfo').doc(userUid);
          try {
            DocumentReference orderRef =
            userInfoDoc.collection("sellHistory").doc(order.orderId.toString());
            DocumentSnapshot orderSnapshot = await orderRef.get();
            await userInfoDoc.update({
              "sellHistory": FieldValue.arrayRemove([order.toJson()])
            });
            currentOrders.remove(order);

            // fetchCurrentOrders();
          } catch (error) {
            print('Error during Firestore query: $error');
            showToast(title: 'Error during Firestore query: $error');
          }
        }
      } catch (error) {
        showToast(title: 'Error canceling order: $error');
      }
    }
  }

  void addOrder(SellOrderModel order) {
    currentOrders.add(order);
  }

  void clearData() {
    currentOrders.clear();
    isLoading(true);
  }
}
