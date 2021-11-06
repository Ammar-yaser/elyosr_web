import 'package:alyosr_order/models/api_response.dart';
import 'package:alyosr_order/models/signed_user_model.dart';
import 'package:alyosr_order/services/check_user_exist/check_user_exist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckUserExistController {
  final CheckUserExist _userExist;
  CheckUserExistController(this._userExist);

  late SignedUserModel _userData;
  SignedUserModel get userData => _userData;

  Future<bool> checkUserExist(String uid) async {
    ApiResponse response = await _userExist.isUserExist(uid);

    if (response.error) {
      throw response.errorMessage!;
    } else {
      DocumentSnapshot<Map<String, dynamic>> data =
          response.data as DocumentSnapshot<Map<String, dynamic>>;
      if (data.exists) {
        _userData = SignedUserModel.fromJson(data.data()!);
        return true;
      } else {
        return false;
      }
    }
  }
}
