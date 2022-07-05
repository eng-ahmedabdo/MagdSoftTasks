import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// final FToast fToast = FToast();
//
// showToast(String? text) {
//   Widget toast = Container(
//     padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(25.0),
//       //color: AppColors.lightGray,
//     ),
//     child: Text(text!),
//   );
//
//   fToast.showToast(
//     child: toast,
//     gravity: ToastGravity.TOP,
//     toastDuration: const Duration(seconds: 2),
//   );
// }


 showToast({
  required String text,
  ToastGravity gravity = ToastGravity.BOTTOM,
}){

  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0
  );
}