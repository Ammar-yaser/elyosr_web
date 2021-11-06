import 'package:alyosr_order/models/api_response.dart';

abstract class CheckUserExist {
  Future<ApiResponse> isUserExist(String uid);
}
