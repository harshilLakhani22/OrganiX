class BuyOrderModel {
  final String orderId;
  final String quantity;
  final DateTime orderDate;
  final bool isAcceptedFromAdmin;
  final bool isCurrentOrder;
  final bool isCancelFromFarmer;
  final String addLine1;
  final String addLine2;
  final String mobile;
  final String name;
  final String village;
  final String pincode;

  BuyOrderModel( {
    required this.addLine1,
    required this.addLine2,
    required this.mobile,
    required this.name,
    required this.village,
    required this.pincode,
    required this.orderId,
    required this.quantity,
    required this.orderDate,
    required this.isAcceptedFromAdmin,
    required this.isCurrentOrder,
    required this.isCancelFromFarmer,
  });

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "quantity": quantity,
    "orderDate": orderDate,
    "isAcceptedFromAdmin": isAcceptedFromAdmin,
    "isCurrentOrder": isCurrentOrder,
    "isCancelFromFarmer": isCancelFromFarmer,
    "addLine1": addLine1,
    "addLine2": addLine2,
    "mobile": mobile,
    "name": name,
    "village": village,
    "pincode": pincode,
  };

}
