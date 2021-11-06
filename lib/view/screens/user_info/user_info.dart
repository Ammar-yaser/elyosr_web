import 'package:alyosr_order/constants.dart';
import 'package:alyosr_order/globals/global_providers.dart';
import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:alyosr_order/globals/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import 'user_info_forms/address_form/address_form.dart';
import 'user_info_forms/personal_details_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        child: Builder(builder: (context) {
          return Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20).copyWith(
                  top: MediaQuery.of(context).size.height >= 750 ? 20 : 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PersonalDetails(),
                  const SizedBox(height: 15),
                  const AddressDetails(),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: 'حفظ',
                    width: 350,
                    onPressed: () => _saveUserInfo(context),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _saveUserInfo(BuildContext context) {
    final progress = ProgressHUD.of(context);
    OrderTypes orderType = context.read(orderTypeProvider);
    var userInfoController = context.read(userInfoProvider);
    userInfoController.userOrdersType = orderType;
    userInfoController.district = context.read(districtProvider);
    progress?.show();
    userInfoController.saveUserData().then((_) {
      progress?.dismiss();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              OrderForm(signedUserData: userInfoController.userData),
        ),
      );
    }).catchError((e) {
      progress?.dismiss();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Align(
            alignment: Alignment.center,
            child: Text(
              e.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    });
  }
}
