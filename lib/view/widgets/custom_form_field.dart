import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final bool showErrorMessage;
  final String title;
  final double? height;
  final int? minLines, maxLines, maxLength;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  const CustomFormField({
    Key? key,
    required this.title,
    this.height = 69,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.validator,
    this.onSaved,
    this.controller,
    this.initialValue,
    this.showErrorMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height == 0 ? null : height,
      child: TextFormField(
        controller: controller,
        textDirection: TextDirection.rtl,
        cursorColor: const Color(0xff4AAE3A),
        initialValue: initialValue,
        decoration: InputDecoration(
          isDense: true,
          hintText: title,
          hintStyle: const TextStyle(fontSize: 13),
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffC3912F)),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          counterText: '',
          errorMaxLines: 1,
          errorStyle: showErrorMessage
              ? const TextStyle(color: Colors.red, fontSize: 12)
              : const TextStyle(
                  color: Colors.transparent,
                  height: 0,
                ),
        ),
        keyboardType: TextInputType.text,
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        validator: validator,
        onSaved: onSaved,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
