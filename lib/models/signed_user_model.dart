import 'package:alyosr_order/constants.dart';

class SignedUserModel {
  String? firstName,
      lastName,
      phoneNumber,
      backupNumber,
      district, // if userOrderType is personal
      shopName, // if userOrderType is commercial
      address;
  OrderTypes? userOrdersType;

  SignedUserModel({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.backupNumber,
    this.userOrdersType,
    this.district,
    this.shopName,
    this.address,
  });

  factory SignedUserModel.fromJson(Map<String, dynamic> json) {
    return SignedUserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      backupNumber: json['backupNumber'],
      userOrdersType: json['userOrdersType'] == 'personal'
          ? OrderTypes.personal
          : OrderTypes.commercial,
      district: json['district'],
      shopName: json['shopName'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'backupNumber': backupNumber,
        'userOrdersType':
            userOrdersType == OrderTypes.personal ? 'personal' : 'commercial',
        'shopName': shopName,
        'district': district,
        'address': address,
      };
}
