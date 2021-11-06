import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'phone_code_picker.dart';

class PhoneNumberField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(CountryCode?)? onCodeChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final String? initialCode, dialCode;

  const PhoneNumberField({
    Key? key,
    required this.onCodeChanged,
    this.dialCode,
    required this.initialCode,
    this.validator,
    this.onSaved,
    this.controller,
  }) : super(key: key);

  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[500]!),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: <Widget>[
            PhoneCodePicker(
              onChanged: widget.onCodeChanged,
              initialCode: widget.initialCode,
            ),
            Expanded(
              child: TextFormField(
                controller: widget.controller,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'أدخل رقم الهاتف',
                  hintTextDirection: TextDirection.rtl,
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.only(right: 5),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                      top: 6,
                      left: 5,
                      right: 3,
                    ),
                    child: Text(
                      widget.dialCode!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 14),
                    ),
                  ),
                ),
                cursorColor: theme.primaryColor,
                style: TextStyle(fontSize: theme.textTheme.subtitle2!.fontSize),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
