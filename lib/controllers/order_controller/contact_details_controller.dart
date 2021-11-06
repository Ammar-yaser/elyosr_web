import 'package:alyosr_order/models/signed_user_model.dart';
import 'package:alyosr_order/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class ContactDetailsController {
  GlobalKey<FormState>? _contactDetailsFormKey;
  UserModel? _data;
  String? _name, _phone, _address;
  SignedUserModel? _fetchedData;

  set name(String val) => _name = val;
  set phone(String val) => _phone = val;
  set address(String val) => _address = val;
  set fetchedData(SignedUserModel val) => _fetchedData = val;
  set contactDetailsFormKey(val) => _contactDetailsFormKey = val;

  UserModel get data => _data!;
  SignedUserModel get fetchedData {
    if (_fetchedData != null) {
      return _fetchedData!;
    } else {
      return SignedUserModel();
    }
  }

  bool saveData() {
    if (_contactDetailsFormKey!.currentState!.validate()) {
      _contactDetailsFormKey!.currentState!.save();
      _data = UserModel(
        name: _name,
        phoneNumber: _phone,
        address: _address,
      );
      return true;
    } else {
      return false;
    }
  }
}
