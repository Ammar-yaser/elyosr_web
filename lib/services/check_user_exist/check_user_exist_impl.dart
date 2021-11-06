import 'package:alyosr_order/models/api_response.dart';
import 'package:alyosr_order/services/check_user_exist/check_user_exist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class CheckUserExistImpl implements CheckUserExist {
  @override
  Future<ApiResponse<DocumentSnapshot<Map<String, dynamic>>>> isUserExist(
      String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> data =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return ApiResponse<DocumentSnapshot<Map<String, dynamic>>>(data: data);
    } on FirebaseException catch (e) {
      return ApiResponse(
          error: true, errorMessage: '$e هناك خطأ ما تأكد من وجود انترنت');
    }
  }
}
