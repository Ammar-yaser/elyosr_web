import 'package:alyosr_order/models/signed_user_model.dart';

class SignedUserData {
  SignedUserModel? _userData;
  set signedUserData(SignedUserModel? val) => _userData = val;

  SignedUserModel get signedUserData => _userData!;
}
