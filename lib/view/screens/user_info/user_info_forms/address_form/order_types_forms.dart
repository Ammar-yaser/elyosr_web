import 'package:alyosr_order/constants.dart';
import 'package:alyosr_order/globals/global_controllers.dart';
import 'package:alyosr_order/globals/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalAddressForm extends StatelessWidget {
  const PersonalAddressForm({Key? key}) : super(key: key);

  static GlobalKey<FormState> personalAddressFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      watch(userInfoProvider).personalAddressFormKey = personalAddressFormKey;
      UserInfoController setters = watch(userInfoProvider);
      return Form(
        key: personalAddressFormKey,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: DropdownButtonHideUnderline(
                child: Consumer(builder: (context, watch, _) {
                  String district = watch(districtProvider);
                  return DropdownButton<String>(
                    dropdownColor: Colors.white,
                    focusColor: Colors.white,
                    isExpanded: true,
                    isDense: true,
                    value: district,
                    items: districts
                        .map<DropdownMenuItem<String>>(
                          (district) => DropdownMenuItem(
                            child: FittedBox(child: Text(district)),
                            value: district,
                          ),
                        )
                        .toList(),
                    onChanged: (district) {
                      watch(districtProvider.notifier)
                          .selectedDistrict(district!);
                    },
                  );
                }),
              ),
            ),
            const SizedBox(height: 15),
            CustomFormField(
              title: 'العنوان بالتفصيل...',
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
              onSaved: (String? val) => setters.address = val!,
            ),
          ],
        ),
      );
    });
  }
}

class CommercialAddressForm extends StatefulWidget {
  const CommercialAddressForm({Key? key}) : super(key: key);

  static GlobalKey<FormState> commercialAddressFormKey = GlobalKey();

  @override
  State<CommercialAddressForm> createState() => _CommercialAddressFormState();
}

class _CommercialAddressFormState extends State<CommercialAddressForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      watch(userInfoProvider).commercialAddressFormKey =
          CommercialAddressForm.commercialAddressFormKey;
      UserInfoController setters = watch(userInfoProvider);
      return Form(
        key: CommercialAddressForm.commercialAddressFormKey,
        child: Column(
          children: [
            CustomFormField(
              title: 'اسم المتجر',
              validator: (String? val) {
                if (val != null && val.isNotEmpty && val.length >= 3) {
                  return null;
                } else {
                  return '';
                }
              },
              onSaved: (String? val) => setters.shopName = val!,
            ),
            CustomFormField(
              title: 'العنوان بالتفصيل...',
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
              onSaved: (String? val) => setters.address = val!,
            ),
          ],
        ),
      );
    });
  }
}
