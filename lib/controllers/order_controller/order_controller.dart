import 'package:alyosr_order/models/api_response.dart';
import 'package:alyosr_order/models/signed_user_model.dart';
import 'package:alyosr_order/models/user_model.dart';
import 'package:alyosr_order/services/save_orders/orders_services.dart';

import 'order_types_controller/order_details_interface.dart';

class OrderController {
  final OrderServices _orderServices;
  OrderController(this._orderServices);

  Order? _orderSaver;

  set orderSaver(Order val) => _orderSaver = val;

  Future sendOrder() async {
    if (_orderSaver!.saveData()) {
      ApiResponse result =
          await _orderServices.saveOrder(_orderSaver!.orderData);
      if (result.error) {
        throw result.errorMessage!;
      } else {
        return result;
      }
    }
  }
}
