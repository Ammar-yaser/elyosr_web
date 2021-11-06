import 'package:alyosr_order/constants.dart';
import 'package:alyosr_order/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommercialOrderModel {
  UserModel? userInfo;
  OrderTypes? orderType;
  String? orderNature, ordersDetails;

  CommercialOrderModel(
      {this.userInfo, this.orderType, this.orderNature, this.ordersDetails});

  factory CommercialOrderModel.fromJson(Map<String, dynamic> json) {
    return CommercialOrderModel(
      userInfo: UserModel(
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
      ),
      orderType: json['orderType'],
      orderNature: json['orderNature'],
      ordersDetails: json['ordersDetails'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': userInfo!.name,
        'phoneNumber': userInfo!.phoneNumber,
        'address': userInfo!.address,
        'orderType': 'commercial',
        'orderNature': orderNature,
        'ordersDetails': ordersDetails,
        'timestamp': FieldValue.serverTimestamp(),
      };
}
