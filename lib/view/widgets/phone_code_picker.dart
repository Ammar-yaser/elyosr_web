import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class PhoneCodePicker extends StatelessWidget {
  final void Function(CountryCode?)? onChanged;
  final String? initialCode;
  const PhoneCodePicker({
    Key? key,
    required this.onChanged,
    required this.initialCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      builder: (code) {
        return Row(
          children: <Widget>[
            const SizedBox(width: 10),
            Image.asset(
              code?.flagUri ?? '',
              package: 'country_code_picker',
              width: 25,
              height: 25,
            ),
            const Icon(Icons.arrow_drop_down),
            VerticalDivider(width: 1, color: Colors.grey[300]),
          ],
        );
      },
      onChanged: onChanged,
      initialSelection: CountryCode(code: initialCode).code,
      showFlagDialog: true,
      favorite: const ['+20', 'EG'],
    );
  }
}
