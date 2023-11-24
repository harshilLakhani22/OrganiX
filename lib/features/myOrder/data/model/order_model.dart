class OrderModel {
  final String orderId;
  final String quantity;
  final DateTime orderDate;
  final bool isAcceptedFromAdmin;
  final bool isCurrentOrder;
  final bool isCancelFromFarmer;

  OrderModel({
    required this.orderId,
    required this.quantity,
    required this.orderDate,
    required this.isAcceptedFromAdmin,
    required this.isCurrentOrder,
    required this.isCancelFromFarmer,
  });
}
