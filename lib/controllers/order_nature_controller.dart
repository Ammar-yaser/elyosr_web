import 'package:alyosr_order/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderNatureController extends StateNotifier<String> {
  OrderNatureController() : super(orderNatures.first);

  void selectedNature(String orderNature) => state = orderNature;
}
