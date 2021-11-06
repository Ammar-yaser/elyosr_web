import 'package:alyosr_order/models/api_response.dart';
import 'package:alyosr_order/models/signed_user_model.dart';

abstract class SaveUserInfo {
  Future<ApiResponse> saveInfo(String uid, SignedUserModel data);
}
