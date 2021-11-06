import 'package:alyosr_order/models/api_response.dart';

abstract class OrderServices {
  Future<ApiResponse> saveOrder(dynamic data);
}
