import 'package:alyosr_order/globals/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:alyosr_order/globals/global_controllers.dart';
import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: const [
        CustomCard(child: PersonalInfoForm()),
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

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({Key? key}) : super(key: key);

  static GlobalKey<FormState> personalInfoFormKey = GlobalKey();

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      watch(userInfoProvider).personalInfoFormKey =
          PersonalInfoForm.personalInfoFormKey;
      UserInfoController setters = watch(userInfoProvider);
      return Form(
        key: PersonalInfoForm.personalInfoFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const PersonalDetailsHeader(),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: CustomFormField(
                    title: 'الاسم الأول',
                    validator: (String? val) {
                      if (val != null && val.isNotEmpty) {
                        return null;
                      } else {
                        return '';
                      }
                    },
                    onSaved: (String? val) => setters.firstName = val,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  flex: 1,
                  child: CustomFormField(
                    title: 'الاسم الأخير',
                    validator: (String? val) {
                      if (val != null && val.isNotEmpty) {
                        return null;
                      } else {
                        return '';
                      }
                    },
                    onSaved: (String? val) => setters.lastName = val,
                  ),
                ),
              ],
            ),
            CustomFormField(
              title: 'رقم الهاتف الاحتياطي',
              maxLength: 11,
              onSaved: (String? val) => setters.backupNumber = val,
            ),
          ],
        ),
      );
    });
  }
}

class PersonalDetailsHeader extends StatelessWidget {
  const PersonalDetailsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            'البيانات الشخصية',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            'حفاظاً على وقتك أدخل بياناتك الشخصية',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}
