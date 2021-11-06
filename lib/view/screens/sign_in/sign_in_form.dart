import 'package:alyosr_order/globals/global_controllers.dart';
import 'package:alyosr_order/globals/global_providers.dart';
import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:alyosr_order/services/local_storage/local_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:alyosr_order/globals/screens.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryCodeProvider =
    StateNotifierProvider<CountryCodeController, String>(
        (ref) => CountryCodeController());

class SignInForm extends ConsumerWidget {
  const SignInForm({Key? key}) : super(key: key);
  static TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context, watch) {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            'تسجيل الدخول',
            style: theme.textTheme.headline6,
          ),
        ),
        const SizedBox(height: 18),
        Consumer(
          builder: (context, watch, _) {
            return PhoneNumberField(
              controller: phoneController,
              initialCode: watch(countryCodeProvider.notifier).initialCode,
              dialCode: watch(countryCodeProvider),
              onCodeChanged: (country) =>
                  watch(countryCodeProvider.notifier).countryCode = country!,
            );
          },
        ),
        const SizedBox(height: 8),
        Consumer(builder: (context, watch, _) {
          String errorMessage = watch(phoneValidateProvider);
          return Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.red,
            ),
          );
        }),
        const SizedBox(height: 15),
        CustomButton(
          title: 'تسجيل الدخول',
          onPressed: () => signIn(context),
        )
      ],
    );
  }

  static void signIn(BuildContext context) {
    final progress = ProgressHUD.of(context);

    String fieldVal = phoneController.text;
    String dialCode = context.read(countryCodeProvider);
    PhoneNumberValidator validatorProvider =
        context.read(phoneValidateProvider.notifier);
    validatorProvider.checkPhoneValidation(fieldVal);
    bool isNumberValid = validatorProvider.isValid;

    if (isNumberValid) {
      progress?.show();
      context.read(authProvider)
        ..number = dialCode + fieldVal
        ..signInWithNumber().then((_) {
          progress?.dismiss();
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const PinCode()));
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
}
