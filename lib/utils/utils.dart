
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {


  static toastMessage(String message){
    Fluttertoast.showToast(msg: message);
  }

  static void flushBarErrorMessage(String message, BuildContext context){
    showFlushbar(context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          titleColor: Colors.white,
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: BorderRadius.circular(10),
          reverseAnimationCurve: Curves.easeOut,
          positionOffset: 20,
          icon: const Icon(Icons.error, size: 20, color: Colors.white,),
          message: message,
          backgroundColor: Colors.red,
          messageColor: Colors.white,
          duration: const Duration(seconds: 3),
        )..show(context),
    );
  }

  static snackBar(String message, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }

  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode next,)
  {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }
}