import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showCustomToast(BuildContext context, String message) {
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.deepPurple.withValues(alpha: 0.75),
    ),
    child: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 14.0),
      textDirection: TextDirection.rtl,
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM_RIGHT,
    toastDuration: const Duration(seconds: 2),
  );
}
