import 'package:alyosr_order/models/personal_order_model.dart';
import 'package:alyosr_order/models/user_model.dart';
import 'package:flutter/cupertino.dart';

import 'order_details_interface.dart';

class PersonalOrderController implements Order<PersonalOrderModel> {
  GlobalKey<FormState>? _personalOrderFormKey = GlobalKey();
  String? _orderDetails;
  UserModel? _userInfo;
  set personalOrderFormKey(val) => _personalOrderFormKey = val;
  set orderDetails(val) => _orderDetails = val;

  @override
  set userInfo(UserModel val) => _userInfo = val;

  @override
  PersonalOrderModel? orderData;

  @override
  bool saveData() {
    if (_personalOrderFormKey!.currentState!.validate()) {
      _personalOrderFormKey!.currentState!.save();
      orderData = PersonalOrderModel(
        userInfo: _userInfo,
        orderDetails: _orderDetails,
      );
      return true;
    } else {
      return false;
    }
  }
}
