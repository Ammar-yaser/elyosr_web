import 'package:alyosr_order/constants.dart';
import 'package:alyosr_order/globals/global_providers.dart';
import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_types_forms.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                'العنوان حسب نوع الطلب',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 15),
            const OrderType(),
            const SizedBox(height: 15),
            const SwitchAddressForms(),
          ],
        ),
      ),
    );
  }
}

class SwitchAddressForms extends ConsumerWidget {
  const SwitchAddressForms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    OrderTypes orderState = watch(orderTypeProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: orderState == OrderTypes.commercial
          ? const CommercialAddressForm()
          : const PersonalAddressForm(),
    );
  }
}
