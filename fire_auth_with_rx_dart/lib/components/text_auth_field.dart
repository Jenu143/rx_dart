import 'package:fire_auth_with_rx_dart/constant/colors.dart';
import 'package:flutter/material.dart';

class TextFieldAuth extends StatelessWidget {
  const TextFieldAuth({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.keyBoardType,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final TextInputType keyBoardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        keyboardType: keyBoardType,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          focusedErrorBorder: borderStyle(ColorName.redColor),
          enabledBorder: borderStyle(ColorName.greyColor),
          hintText: hintText,
          errorBorder: borderStyle(ColorName.redColor.withOpacity(0.7)),
          focusedBorder: borderStyle(ColorName.greenColor),
        ),
      ),
    );
  }

  OutlineInputBorder borderStyle(Color colors) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: colors, width: 2),
    );
  }
}
