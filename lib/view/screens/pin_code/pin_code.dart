import 'package:alyosr_order/controllers/sign_in_controller/check_user_exist_controller.dart';
import 'package:alyosr_order/globals/global_providers.dart';
import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:alyosr_order/globals/screens.dart';
import 'package:alyosr_order/services/local_storage/local_storage_helper.dart';
import 'package:alyosr_order/view/screens/sign_in/sign_in_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pin_resend.dart';

class PinCode extends StatelessWidget {
  const PinCode({Key? key}) : super(key: key);
  static TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        child: Builder(builder: (context) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: CustomCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        'أدخل رمز التأكيد',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    PinCodeTextField(
                      controller: pinCodeController,
                      appContext: context,
                      length: 6,
                      onChanged: (String value) {},
                      textInputAction: TextInputAction.done,
                      pinTheme: const PinTheme.defaults(
                        fieldHeight: 35,
                        shape: PinCodeFieldShape.box,
                        inactiveColor: Colors.blueGrey,
                        selectedColor: Color(0xffC3912F),
                        activeColor: Color(0xff360E54),
                      ),
                      autoFocus: true,
                    ),
                    PinResend(
                      resendCode: () {
                        context
                            .read(authProvider)
                            .signInWithNumber()
                            .catchError((e) {
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
                      },
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                      title: 'تأكيد',
                      onPressed: () {
                        _confirmPinCode(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _confirmPinCode(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    String pinCode = pinCodeController.text;
    progress?.show();
    context
        .read(authProvider)
        .confirmNumWithOTP(pinCode)
        .then(
          (UserCredential userData) => _checkUserExist(context, userData),
        )
        .catchError((e) {
      progress?.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    });
  }

  void _checkUserExist(BuildContext context, UserCredential userData) async {
    String userId = userData.user!.uid;
    LocalStorageHelper.saveValue('id', userId);
    final progress = ProgressHUD.of(context);
    CheckUserExistController userExist = context.read(userExistProvider);

    bool isUserExist = await userExist.checkUserExist(userId).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    });

    if (isUserExist) {
      progress?.dismiss();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderForm(
              signedUserData: userExist.userData,
            ),
          ));
    } else {
      progress?.dismiss();
      context.read(userInfoProvider).signInData = userData;
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const UserInfoScreen()));
    }
  }
}
