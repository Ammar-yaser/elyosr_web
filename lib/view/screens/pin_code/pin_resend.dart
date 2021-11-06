import 'package:alyosr_order/globals/screens.dart';
import 'package:flutter/material.dart';

class PinResend extends StatelessWidget {
  const PinResend({Key? key, this.resendCode}) : super(key: key);

  final void Function()? resendCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 1,
          child: TextButton(
            onPressed: resendCode,
            child: const Text(
              'أعد إرسال الكود',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => const SignIn()));
            },
            child: Text(
              'تحقق من الرقم',
              style: TextStyle(
                fontSize: 15,
                color: Colors.red.withOpacity(0.6),
              ),
            ),
          ),
        )
      ],
    );
  }
}
