import 'package:alyosr_order/models/api_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'orders_services.dart';

class CommercialOrderServices implements OrderServices {
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection(orders);
  static const String orders = 'orders';
  static const String ordersType = 'commercialOrders';

  @override
  Future<ApiResponse> saveOrder(dynamic data) async {
    try {
      await _firestore
          .doc(ordersType)
          .collection(ordersType)
          .add(data.toJson());
      return ApiResponse();
    } catch (e) {
      return ApiResponse(error: true, errorMessage: 'يوجد خطأ ما');
    }
  }
}
