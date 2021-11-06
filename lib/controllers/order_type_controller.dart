import 'package:alyosr_order/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderTypeController extends StateNotifier<OrderTypes> {
  OrderTypeController() : super(OrderTypes.personal);

  void selectOrderType(OrderTypes selectedType) {
    state = selectedType;
  }
}
