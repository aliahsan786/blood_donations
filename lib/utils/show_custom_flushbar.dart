import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget showMsg(context, String msg, {Color? bgColor, int? seconds}) {
  return Flushbar(
    backgroundColor: bgColor ?? Color(0xffED2C23),
    message: msg,
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    padding: EdgeInsets.all(22),
    messageColor: Color(0xffFFFFFF),
    messageSize: 14,
    duration: Duration(seconds: seconds ?? 3),
  )..show(context);
}
