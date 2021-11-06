import 'package:alyosr_order/constants.dart';
import 'package:alyosr_order/globals/global_providers.dart';
import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:alyosr_order/models/signed_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'commercial_order.dart';
import 'personal_order.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);
  static SignedUserModel? signedUserController;

  @override
  Widget build(BuildContext context) {
    signedUserController = context.read(signedUserDataProvider).signedUserData;
    context.read(orderTypeProvider.notifier).selectOrderType(
        signedUserController?.userOrdersType ?? OrderTypes.personal);
    return Card(
      elevation: 3,
      color: const Color(0xffE6E7E9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 350,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                'تفاصيل الطلب',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 15),
            const OrderType(),
            const SizedBox(height: 15),
            const SwitchOrderDetailsForms()
          ],
        ),
      ),
    );
  }
}

class SwitchOrderDetailsForms extends ConsumerWidget {
  const SwitchOrderDetailsForms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    OrderTypes orderState = watch(orderTypeProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: orderState == OrderTypes.commercial
          ? const CommercialOrderDetails()
          : const PersonalOrderDetails(),
    );
  }
}
