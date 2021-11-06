import 'package:alyosr_order/models/user_model.dart';

abstract class Order<T> {
  T? orderData;
  UserModel? _userInfo;
  set userInfo(UserModel val) => _userInfo = val;
  bool saveData();
}
