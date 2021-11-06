import 'package:alyosr_order/globals/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import 'sign_in_form.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: const [
                CustomCard(child: SignInForm()),
                Positioned(
                  top: -45,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage("assets/images/alyosr_icon.jpg"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
