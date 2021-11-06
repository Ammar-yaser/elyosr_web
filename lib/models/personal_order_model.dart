import 'package:alyosr_order/constants.dart';
import 'package:alyosr_order/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalOrderModel {
  UserModel? userInfo;
  OrderTypes? orderType;
  String? orderDetails;
  PersonalOrderModel({this.userInfo, this.orderType, this.orderDetails});

  factory PersonalOrderModel.fromJson(Map<String, dynamic> json) {
    return PersonalOrderModel(
      userInfo: UserModel(
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
      ),
      orderType: json['orderType'],
      orderDetails: json['ordersDetails'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': userInfo!.name,
        'phoneNumber': userInfo!.phoneNumber,
        'address': userInfo!.address,
        'orderType': 'personal',
        'orderDetails': orderDetails,
        'timestamp': FieldValue.serverTimestamp(),
      };
}
