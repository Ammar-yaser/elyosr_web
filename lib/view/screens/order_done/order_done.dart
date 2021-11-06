import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:alyosr_order/globals/screens.dart';
import 'package:flutter/material.dart';

class OrderDoneScreen extends StatelessWidget {
  const OrderDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: CustomCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'تم إرسال طلبك بنجاح شكراً لاستخدامك خدمة اليسر للتوصيل الحر',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: const Color(0xff4AAE3A),
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                CustomButton(
                  title: 'إرسال طلب أخر',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 20),
                // CustomButton(
                //   title: 'إنهاء الطلب',
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (_) => const UserInfoScreen(),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
