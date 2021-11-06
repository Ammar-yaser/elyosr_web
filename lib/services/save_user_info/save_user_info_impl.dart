import 'package:alyosr_order/models/api_response.dart';
import 'package:alyosr_order/models/signed_user_model.dart';
import 'package:alyosr_order/services/save_user_info/save_user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SaveUserInfoImpl implements SaveUserInfo {
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection(userCollection);
  static const String userCollection = 'users';
  @override
  Future<ApiResponse<SignedUserModel>> saveInfo(
      String uid, SignedUserModel data) async {
    try {
      await _firestore.doc(uid).set(data.toJson());
      return ApiResponse();
    } on FirebaseException catch (e) {
      print(e);
      return ApiResponse(error: true, errorMessage: '$e يوجد خطأ ما');
    }
  }
}
