import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:alyosr_order/globals/screens.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: CustomCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                title: 'سجل واطلب',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignIn()),
                  );
                },
              ),
              const SizedBox(height: 10),
              CustomButton(
                title: 'اطلب بدون تسجيل',
                btnColor: Colors.blueGrey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OrderForm()),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
