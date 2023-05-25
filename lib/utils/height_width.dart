import 'package:flutter/material.dart';

height(context, double height) {
  return MediaQuery.of(context).size.height * height;
}

width(context, width) {
  return MediaQuery.of(context).size.width * width;
}
