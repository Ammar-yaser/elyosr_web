import 'package:alyosr_order/constants.dart';
import 'package:alyosr_order/globals/global_controllers.dart';
import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderNatureProvider =
    StateNotifierProvider<OrderNatureController, String>(
        (ref) => OrderNatureController());
final commercialOrderProvider = Provider((ref) => CommercialOrderController());

class CommercialOrderDetails extends StatelessWidget {
  const CommercialOrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        OrderNature(),
        SizedBox(height: 15),
        OrderAddressRange(),
      ],
    );
  }
}

class OrderNature extends StatelessWidget {
  const OrderNature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'طبيعة الطلب: ',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            child: DropdownButtonHideUnderline(
              child: Consumer(builder: (context, watch, _) {
                String orderNature = watch(orderNatureProvider);
                return DropdownButton<String>(
                  dropdownColor: Colors.white,
                  focusColor: Colors.white,
                  isExpanded: true,
                  isDense: true,
                  value: orderNature,
                  items: orderNatures
                      .map<DropdownMenuItem<String>>(
                        (orderNature) => DropdownMenuItem(
                          child: FittedBox(child: Text(orderNature)),
                          value: orderNature,
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    watch(orderNatureProvider.notifier).selectedNature(val!);
                    watch(commercialOrderProvider).orderNature = val;
                  },
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class OrderAddressRange extends StatefulWidget {
  const OrderAddressRange({Key? key}) : super(key: key);

  static final GlobalKey<FormState> commercialOrderFormKey = GlobalKey();

  @override
  State<OrderAddressRange> createState() => _OrderAddressRangeState();
}

class _OrderAddressRangeState extends State<OrderAddressRange> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            'عدد الطلبات واتجاهاتها',
            style:
                Theme.of(context).textTheme.headline6?.copyWith(fontSize: 18),
          ),
        ),
        Consumer(builder: (context, watch, _) {
          CommercialOrderController setters = watch(commercialOrderProvider);
          setters.commercialOrderFormKey =
              OrderAddressRange.commercialOrderFormKey;
          return Form(
            key: OrderAddressRange.commercialOrderFormKey,
            child: CustomFormField(
              title: 'مثال: (2 العرب-1 بورفؤاد)',
              height: 0,
              minLines: 2,
              maxLines: 4,
              validator: (String? val) {
                if (val != null && val.isNotEmpty && val.length >= 3) {
                  return null;
                } else {
                  return '';
                }
              },
              onSaved: (String? val) => setters.ordersDetails = val!,
            ),
          );
        }),
      ],
    );
  }
}
