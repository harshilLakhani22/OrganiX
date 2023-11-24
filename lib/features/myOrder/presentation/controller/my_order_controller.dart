import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:organix/core/methods/methods.dart';
import 'package:organix/features/myOrder/data/model/order_model.dart';
import 'package:organix/features/myOrder/presentation/widgets/current_order/fail_cancel_order_dialog.dart';

class OrderController extends GetxController {
  var currentOrders = <OrderModel>[].obs;
  var isLoading = true.obs;
  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCurrentOrders();
  }

  void fetchCurrentOrders() async {
    try {
      isLoading(true);
      var ordersFromFirestore = await fetchOrdersFromFirestore();
      currentOrders.assignAll(ordersFromFirestore);
    } catch (error) {
      showToast(title: 'Error fetching orders: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<List<OrderModel>> fetchOrdersFromFirestore() async {
    String? userUid = getUserUid();

    if (userUid != null) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('userInfo')
          .where('uid', isEqualTo: userUid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var data = querySnapshot.docs.first.data();
        var history = data['history'] ?? [];

        List<OrderModel> orders = [];

        history.forEach((orderData) {
          orders.add(OrderModel(
            orderId: orderData['orderId'],
            quantity: orderData['quantity'] ?? '',
            orderDate: (orderData['orderDate'] as Timestamp).toDate(),
            isAcceptedFromAdmin: orderData['isAcceptedFromAdmin'] ?? false,
            isCurrentOrder: orderData['isCurrentOrder'] ?? true,
            isCancelFromFarmer: orderData['isCancelFromFarmer'] ?? false,
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

  String? getUserUid() {
    return box.read('uid');
  }


  void cancelOrder(OrderModel order) async {
    if (order.isAcceptedFromAdmin) {
      Get.dialog(const FailCancelOrderDialog());
    } else {
      try {
        String? userUid = getUserUid();

        if (userUid != null) {
          var userInfoDoc = FirebaseFirestore.instance.collection('userInfo').doc(userUid);

          try {
            QuerySnapshot queryOrder = await userInfoDoc.collection("history").where(
              'orderId', isEqualTo: order.orderId,
            ).get();

            print('Documents in query result: ${queryOrder.docs.length}');

            for (var doc in queryOrder.docs) {
              print('Document ID: ${doc.id}, Order ID: ${doc['orderId']}');
            }

            if (queryOrder.docs.isNotEmpty) {
              print("Entering if statement");
              var orderDocument = queryOrder.docs.first.reference;
              await orderDocument.delete();

              // You may also update local state here if needed
              currentOrders.remove(order);
            } else {
              // Handle case where order is not found in history
              print("Order ID not found: ${order.orderId}");
              showToast(title: 'Order not found in history.');
            }

            // Refresh the list of currentOrders from Firestore
            fetchCurrentOrders();
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

  // Add this method to handle adding orders
  void addOrder(OrderModel order) {
    currentOrders.add(order);
  }
}
