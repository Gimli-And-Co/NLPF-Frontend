import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nlpf_web_app/utils/constants/color.consts.dart';

class ToastsUtils {
  static Future<bool> displayToast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: COLOR_PRIMARY,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static SnackBar displaySnackBar(String message,
      {String actionMessage, VoidCallback onClick}) {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
      action: (actionMessage != null)
          ? SnackBarAction(
              textColor: Colors.white,
              label: actionMessage,
              onPressed: () {
                return onClick();
              },
            )
          : null,
      duration: Duration(seconds: 2),
      backgroundColor: COLOR_PRIMARY,
    );
  }
}
