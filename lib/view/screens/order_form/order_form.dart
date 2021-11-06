import 'package:alyosr_order/controllers/order_controller/order_types_controller/order_details_interface.dart';
import 'package:alyosr_order/models/signed_user_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:alyosr_order/constants.dart';
import 'package:alyosr_order/globals/global_providers.dart';
import 'package:alyosr_order/globals/services.dart';
import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:alyosr_order/globals/screens.dart';
import 'package:alyosr_order/globals/global_controllers.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_details/order_details.dart';

final orderController = Provider.family(
  (ref, OrderServices services) => OrderController(services),
);

class OrderForm extends StatelessWidget {
  final SignedUserModel? signedUserData;
  const OrderForm({Key? key, this.signedUserData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read(signedUserDataProvider).signedUserData =
        signedUserData ?? SignedUserModel();

    return Scaffold(
      body: ProgressHUD(
        child: Builder(builder: (context) {
          return Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20).copyWith(
                  top: MediaQuery.of(context).size.height >= 750 ? 20 : 50),
              child: Column(
                children: [
                  const ContactDetails(),
                  const SizedBox(height: 18),
                  const OrderDetails(),
                  const SizedBox(height: 18),
                  CustomButton(
                    title: 'إرسال الطلب',
                    width: 350,
                    onPressed: () => _orderFormbtn(context),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _orderFormbtn(BuildContext context) async {
    Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult != ConnectivityResult.none) {
        OrderTypes orderType = context.read(orderTypeProvider);
        ContactDetailsController contactDetails =
            context.read(contactDetailsProvider);
        CommercialOrderController commercialOrder =
            context.read(commercialOrderProvider);
        PersonalOrderController personalOrder =
            context.read(personalOrderProvider);

        if (contactDetails.saveData()) {
          if (orderType == OrderTypes.commercial) {
            commercialOrder.orderNature = context.read(orderNatureProvider);
            _saveOrder(context, commercialOrder, CommercialOrderServices());
          } else {
            _saveOrder(context, personalOrder, PersonalOrderServices());
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يوجد انترنت')),
        );
      }
    });
  }

  void _saveOrder(
      BuildContext context, Order orderTypeController, OrderServices services) {
    final progress = ProgressHUD.of(context);
    progress?.show();
    ContactDetailsController contactDetails =
        context.read(contactDetailsProvider);
    orderTypeController.userInfo = contactDetails.data;
    progress?.show();
    context.read(orderController(services))
      ..orderSaver = orderTypeController
      ..sendOrder().catchError((e) {
        progress?.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }).then((_) {
        progress?.dismiss();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const OrderDoneScreen(),
            ));
      });
  }
}
