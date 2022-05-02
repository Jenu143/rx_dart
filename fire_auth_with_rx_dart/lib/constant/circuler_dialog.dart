import 'package:flutter/material.dart';

Future<void> circulerDialog({required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      });
}
