import 'package:flutter/material.dart';

Future<void> commanDialog({required BuildContext context, String? error}) {
  return showDialog(
      context: context,
      builder: (context) {
        return  AlertDialog(title: Text(error!));
      });
}
