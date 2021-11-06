import 'dart:io';

import 'package:alyosr_order/models/api_response.dart';
import 'package:alyosr_order/services/save_orders/orders_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PersonalOrderServices implements OrderServices {
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection(orders);
  static const String orders = 'orders';
  static const String ordersType = 'personalOrders';

  @override
  Future<ApiResponse> saveOrder(dynamic data) async {
    try {
      await _firestore
          .doc(ordersType)
          .collection(ordersType)
          .add(data.toJson());
      return ApiResponse();
    } on FirebaseException catch (e) {
      return ApiResponse(error: true, errorMessage: '$e يوجد خطأ ما');
    }
  }
}
