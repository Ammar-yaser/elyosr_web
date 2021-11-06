import 'package:alyosr_order/models/api_response.dart';

abstract class AuthServices {
  Future<ApiResponse> signInWithPhoneNumber(String phoneNum);
  Future<ApiResponse> confirmOTP(signInResult, String pinCode);
}
