import 'package:country_code_picker/country_code.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountryCodeController extends StateNotifier<String> {
  static const String _initialCode = 'EG';
  CountryCodeController() : super('+20');

  String get initialCode => _initialCode;

  set countryCode(CountryCode val) {
    state = val.dialCode!;
  }
}
