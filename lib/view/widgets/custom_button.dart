import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final Color? btnColor;
  final void Function() onPressed;
  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.width = 250,
    this.btnColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width,
      height: 45,
      color: btnColor ?? const Color(0xff4AAE3A), //360E55
      elevation: 2,
      textColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(title),
      onPressed: onPressed,
    );
  }
}
