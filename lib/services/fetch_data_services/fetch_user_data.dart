import 'package:alyosr_order/models/signed_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'fetch_user_data_impl.dart';

class FetchUserDataImpl implements FetchUserData {
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection(userCollection);
  static const String userCollection = 'users';

  @override
  Future<SignedUserModel> fetchData(String uid) async {
    // try {
    Map<String, dynamic> jsonData = await _firestore
        .doc(uid)
        .get()
        .then((value) => value.data() as Map<String, dynamic>);
    return SignedUserModel.fromJson(jsonData);
    // return ApiResponse();
    // } catch (e) {
    //   return ApiResponse();
    // }
  }
}
