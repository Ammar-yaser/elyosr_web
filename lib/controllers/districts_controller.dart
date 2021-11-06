import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alyosr_order/constants.dart';

class DistrictController extends StateNotifier<String> {
  DistrictController() : super(districts.first);

  void selectedDistrict(String district) => state = district;
}
