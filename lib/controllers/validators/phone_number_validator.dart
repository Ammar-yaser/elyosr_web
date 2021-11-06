import 'package:alyosr_order/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

RegExp usernameRegExp =
    RegExp(r"^[أ-ي a-zA-zàâäèéêëîïôœùûüÿçÀÂÄÈÉÊËÎÏÔŒÙÛÜŸÇ]{3,50}$");

class PhoneNumberValidator extends StateNotifier<String> {
  PhoneNumberValidator() : super('');

  bool _isValid = false;

  bool get isValid => _isValid;

  void checkPhoneValidation(String? phoneNumber) {
    if (phoneNumber!.isEmpty) {
      state = 'أدخل رقم الهاتف';
      _isValid = false;
    } else if (!phoneRegExp2.hasMatch(phoneNumber)) {
      state = 'تأكد من صحة الرقم';
      _isValid = false;
    } else {
      _isValid = true;
    }
  }
}
