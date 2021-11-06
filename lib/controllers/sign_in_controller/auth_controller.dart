import 'package:alyosr_order/models/api_response.dart';
import 'package:alyosr_order/services/auth_services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final AuthServices _authServices;
  AuthController(this._authServices);
  late ConfirmationResult _signInResult;

  String? _number;

  set number(String val) => _number = val;

  Future<ApiResponse> signInWithNumber() async {
    ApiResponse result = await _authServices.signInWithPhoneNumber(_number!);
    if (result.error) {
      throw result.errorMessage!;
    } else {
      _signInResult = result.data;
      return result;
    }
  }

  Future<UserCredential> confirmNumWithOTP(String pinCode) async {
    ApiResponse result = await _authServices.confirmOTP(_signInResult, pinCode);

    if (result.error) {
      throw result.errorMessage!;
    } else {
      return result.data;
    }
  }
}
