import 'package:alyosr_order/models/api_response.dart';

abstract class FetchUserData {
  Future fetchData(String uid);
}
