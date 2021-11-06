import 'package:alyosr_order/models/signed_user_model.dart';
import 'package:alyosr_order/services/auth_services/auth_services_impl.dart';
import 'package:alyosr_order/services/check_user_exist/check_user_exist_impl.dart';
import 'package:alyosr_order/services/fetch_data_services/fetch_user_data.dart';
import 'package:alyosr_order/services/save_user_info/save_user_info_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import 'global_controllers.dart';

final phoneValidateProvider =
    StateNotifierProvider<PhoneNumberValidator, String>(
        (ref) => PhoneNumberValidator());

final orderTypeProvider =
    StateNotifierProvider<OrderTypeController, OrderTypes>(
  (ref) => OrderTypeController(),
);

final authProvider = Provider((ref) => AuthController(AuthServiceImpl()));

final districtProvider = StateNotifierProvider<DistrictController, String>(
    (ref) => DistrictController());

final userExistProvider =
    Provider((ref) => CheckUserExistController(CheckUserExistImpl()));

final userInfoProvider = Provider(
  (ref) {
    return UserInfoController(SaveUserInfoImpl());
  },
);

final fetchDataProvider = FutureProvider.autoDispose
    .family<SignedUserModel, String>((ref, String uid) {
  return FetchUserDataImpl().fetchData(uid);
});

final signedUserDataProvider = Provider((ref) => SignedUserData());
