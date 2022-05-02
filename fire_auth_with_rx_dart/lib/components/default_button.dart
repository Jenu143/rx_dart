import 'package:fire_auth_with_rx_dart/constant/colors.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.press,
    required this.name,
  }) : super(key: key);

  final VoidCallback press;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(ColorName.blackColor.withOpacity(0.8)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        onPressed: press,
        child: Text(name),
      ),
    );
  }
}
