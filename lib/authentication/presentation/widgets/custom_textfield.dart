import 'package:flutter/material.dart';
import 'package:turbo/app/utils/theme/style.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController textController;
  final String label;
  final String hint;
  final TextInputType textInputType;

  const CustomTextfield(
      {super.key,
      required this.label,
      required this.textInputType,
      required this.textController,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 4.0),
        Container(
          alignment: Alignment.center,
          decoration: Styles.kBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            keyboardType: textInputType,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field cannot be empty';
              }
              return null;
            },
            controller: textController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 20.0),
              hintText: hint,
              hintStyle: Styles.kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
