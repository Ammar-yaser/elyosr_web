import 'package:alyosr_order/constants.dart';
import 'package:alyosr_order/models/api_response.dart';
import 'package:alyosr_order/models/signed_user_model.dart';
import 'package:alyosr_order/services/save_user_info/save_user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserInfoController {
  final SaveUserInfo _userInfo;
  UserInfoController(this._userInfo);
  UserCredential?
      _signInData; // to get phone number and user id from signing in
  String? _firstName,
      _lastName,
      _backupNumber,
      _district, // if userOrderType is personal
      _shopName, // if userOrderType is commercial
      _address;
  OrderTypes? _userOrdersType;
  SignedUserModel? _userData;

  // setters
  set signInData(UserCredential? val) => _signInData = val;
  set firstName(val) => _firstName = val;
  set lastName(val) => _lastName = val;
  set backupNumber(val) => _backupNumber = val;
  set userOrdersType(OrderTypes val) => _userOrdersType = val;
  set district(val) => _district = val;
  set shopName(val) => _shopName = val;
  set address(val) => _address = val;

  UserCredential get signInData => _signInData!;
  SignedUserModel get userData => _userData!;

  /* -------------------------- */
  GlobalKey<FormState>? _personalDetailsFormKey;
  GlobalKey<FormState>? _personalAddressFormKey;
  GlobalKey<FormState>? _commercialAddressFormKey;
  set personalInfoFormKey(val) => _personalDetailsFormKey = val;
  set personalAddressFormKey(val) => _personalAddressFormKey = val;
  set commercialAddressFormKey(val) => _commercialAddressFormKey = val;
  /* -------------------------- */

  Future<void> saveUserData() async {
    switch (_userOrdersType!) {
      case OrderTypes.personal:
        if (_personalDetailsFormKey!.currentState!.validate() &&
            _personalAddressFormKey!.currentState!.validate()) {
          _personalDetailsFormKey!.currentState!.save();
          _personalAddressFormKey!.currentState!.save();
          await saveDataToDB();
        }
        break;
      case OrderTypes.commercial:
        if (_personalDetailsFormKey!.currentState!.validate() &&
            _commercialAddressFormKey!.currentState!.validate()) {
          _personalDetailsFormKey!.currentState!.save();
          _commercialAddressFormKey!.currentState!.save();
          await saveDataToDB();
        }

        break;
    }
  }

  Future<void> saveDataToDB() async {
    _userData = SignedUserModel(
      firstName: _firstName,
      lastName: _lastName,
      phoneNumber: _signInData!.user!.phoneNumber,
      backupNumber: _backupNumber,
      userOrdersType: _userOrdersType,
      district: _district,
      shopName: _shopName,
      address: _address,
    );
    ApiResponse response =
        await _userInfo.saveInfo(_signInData!.user!.uid, _userData!);

    if (response.error) {
      throw response.errorMessage!;
    }
  }
}
