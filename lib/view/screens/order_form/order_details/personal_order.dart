import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alyosr_order/globals/global_controllers.dart';

final personalOrderProvider = Provider((ref) => PersonalOrderController());

class PersonalOrderDetails extends StatefulWidget {
  const PersonalOrderDetails({Key? key}) : super(key: key);

  static final GlobalKey<FormState> personalOrderFormKey = GlobalKey();

  @override
  State<PersonalOrderDetails> createState() => _PersonalOrderDetailsState();
}

class _PersonalOrderDetailsState extends State<PersonalOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      PersonalOrderController setters = watch(personalOrderProvider);
      setters.personalOrderFormKey = PersonalOrderDetails.personalOrderFormKey;
      return Form(
        key: PersonalOrderDetails.personalOrderFormKey,
        child: CustomFormField(
          title: 'اكتب طلبك بالتفصيييل...',
          height: 0,
          minLines: 2,
          maxLines: 5,
          validator: (String? val) {
            if (val != null && val.isNotEmpty && val.length >= 3) {
              return null;
            } else {
              return '';
            }
          },
          onSaved: (String? val) => setters.orderDetails = val!,
        ),
      );
    });
  }
}
