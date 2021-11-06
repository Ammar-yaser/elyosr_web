import 'package:alyosr_order/constants.dart';
import 'package:alyosr_order/globals/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderType extends StatelessWidget {
  const OrderType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const OrderTypeItem(
          title: 'طلب شخصي',
          value: OrderTypes.personal,
        ),
        Flexible(
          flex: 1,
          child: Container(),
        ),
        const OrderTypeItem(
          title: 'طلب تجاري',
          value: OrderTypes.commercial,
        ),
      ],
    );
  }
}

class OrderTypeItem extends StatelessWidget {
  final String title;
  final OrderTypes value;
  const OrderTypeItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Flexible(
      flex: 3,
      child: Row(
        children: [
          Consumer(
            builder: (context, ScopedReader watch, child) {
              OrderTypes state = watch(orderTypeProvider);
              return Radio<OrderTypes>(
                value: value,
                groupValue: state,
                onChanged: (val) {
                  context
                      .read(orderTypeProvider.notifier)
                      .selectOrderType(val!);
                },
              );
            },
          ),
          Expanded(
            child: Text(
              title,
              style: theme.subtitle2,
            ),
          )
        ],
      ),
    );
  }
}
