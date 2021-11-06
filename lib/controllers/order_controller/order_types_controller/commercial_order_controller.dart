import 'package:alyosr_order/constants.dart';
import 'package:alyosr_order/models/commercial_order_model.dart';
import 'package:alyosr_order/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'order_details_interface.dart';

class CommercialOrderController implements Order<CommercialOrderModel> {
  String? _ordersDetails, _orderNature;
  UserModel? _userInfo;

  GlobalKey<FormState>? _commercialOrderFormKey = GlobalKey();

  set ordersDetails(String val) => _ordersDetails = val;
  set orderNature(String val) => _orderNature = val;
  set commercialOrderFormKey(val) => _commercialOrderFormKey = val;
  @override
  set userInfo(UserModel val) => _userInfo = val;

  @override
  CommercialOrderModel? orderData;

  @override
  bool saveData() {
    if (_commercialOrderFormKey!.currentState!.validate()) {
      _commercialOrderFormKey!.currentState!.save();
      orderData = CommercialOrderModel(
        userInfo: _userInfo,
        orderNature: _orderNature,
        ordersDetails: _ordersDetails,
      );
      return true;
    } else {
      return false;
    }
  }
}
