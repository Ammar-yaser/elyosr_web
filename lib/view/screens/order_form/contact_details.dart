import 'package:alyosr_order/globals/global_providers.dart';
import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:alyosr_order/models/signed_user_model.dart';
import 'package:flutter/material.dart';
import 'package:alyosr_order/globals/global_controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactDetailsProvider = Provider((ref) => ContactDetailsController());

class ContactDetails extends StatelessWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: const [
        CustomCard(child: ContactDetailsForm()),
        Positioned(
          top: -35,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xff360E54),
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class ContactDetailsForm extends StatefulWidget {
  const ContactDetailsForm({Key? key}) : super(key: key);
  static final GlobalKey<FormState> contactFormKey = GlobalKey();

  @override
  State<ContactDetailsForm> createState() => _ContactDetailsFormState();
}

class _ContactDetailsFormState extends State<ContactDetailsForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      ContactDetailsController contactController =
          watch(contactDetailsProvider);
      contactController.contactDetailsFormKey =
          ContactDetailsForm.contactFormKey;
      SignedUserModel? signedUserController =
          watch(signedUserDataProvider).signedUserData;
      return Form(
        key: ContactDetailsForm.contactFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                'البيانات الشخصية',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 10),
            CustomFormField(
              initialValue: signedUserController.firstName == null
                  ? null
                  : '${signedUserController.firstName} ${signedUserController.lastName}',
              title: 'الاسم',
              validator: (String? val) {
                if (val != null && val.isNotEmpty && val.length >= 3) {
                  return null;
                } else {
                  return '';
                }
              },
              onSaved: (String? val) => contactController.name = val!,
            ),
            CustomFormField(
              initialValue: signedUserController.phoneNumber?.substring(2),
              title: 'رقم الهاتف',
              maxLength: 11,
              validator: (String? val) {
                if (val != null && val.isNotEmpty && val.length == 11) {
                  return null;
                } else {
                  return '';
                }
              },
              onSaved: (String? val) => contactController.phone = val!,
            ),
            CustomFormField(
              initialValue: signedUserController.address,
              title: 'العنوان بالتفصيل(عمارة-دور-شقة-علامة مميزة)',
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
              onSaved: (String? val) => contactController.address = val!,
            ),
          ],
        ),
      );
    });
  }
}
