import 'package:cloud_firestore/cloud_firestore.dart';

class SellOrderModel {
  final String orderId;
  final String quantity;
  final DateTime orderDate;
  final String rawMaterialType;
  final String addLine1;
  final String addLine2;
  final String mobile;
  final String name;
  final String village;
  final String pincode;
  final bool isAcceptedFromAdmin;
  final bool isCurrentOrder;
  final bool isCancelFromFarmer;

  SellOrderModel({
    required this.orderId,
    required this.quantity,
    required this.orderDate,
    required this.rawMaterialType,
    required this.addLine1,
    required this.addLine2,
    required this.mobile,
    required this.name,
    required this.village,
    required this.pincode,
    required this.isAcceptedFromAdmin,
    required this.isCurrentOrder,
    required this.isCancelFromFarmer,
  });

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "quantity": quantity,
    "orderDate": orderDate,
    "rawMaterialType": rawMaterialType,
    "addLine1": addLine1,
    "addLine2": addLine2,
    "mobile": mobile,
    "name": name,
    "village": village,
    "pincode": pincode,
    "isAcceptedFromAdmin" : isAcceptedFromAdmin,
    "isCurrentOrder" : isCurrentOrder,
    "isCancelFromFarmer" : isCancelFromFarmer,
  };

  factory SellOrderModel.fromMap(Map<String, dynamic> map) {
    return SellOrderModel(
      orderId: map['orderId'],
      quantity: map['quantity'],
      orderDate: map['orderDate'].toDate(),
      rawMaterialType: map['rawMaterialType'],
      addLine1: map['addLine1'],
      addLine2: map['addLine2'],
      mobile: map['mobile'],
      name: map['name'],
      village: map['village'],
      pincode: map['pincode'],
      isAcceptedFromAdmin: map['isAcceptedFromAdmin'],
      isCurrentOrder: map['isCurrentOrder'],
      isCancelFromFarmer: map['isCancelFromFarmer'],
    );
  }
}
