// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:blood_donations/constant/color.dart';
import 'package:blood_donations/constant/style.dart';

class MyDropDownFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? dropDownText;
  final String? initialValue;
  final Function(String)? validator;
  final Function(String)? onChange;
  final List<String> list;

  const MyDropDownFormField({
    Key? key,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.validator,
    this.onChange,
    required this.list,
    this.dropDownText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          hintText: hintText,
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // border: OutlineInputBorder(),
        ),
        // decoration: InputDecoration(
        //   border: InputBorder.none,
        //   errorBorder: InputBorder.none,
        //   enabledBorder: InputBorder.none,
        //   focusedBorder: InputBorder.none,
        //   focusedErrorBorder: InputBorder.none,
        // ),
        validator: (value) => validator!(initialValue!),

        hint: Text(
          dropDownText ?? "",
          style: dropDownSignUpText,
        ),
        dropdownColor: Colors.white,

        icon: Icon(FontAwesomeIcons.angleDown, color: Colors.black, size: 18),
        iconSize: 30,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: kPrimaryColor,
          fontSize: 16.0,
        ),
        isExpanded: true,
        value: initialValue,
        onChanged: (value) => onChange!(value!),
        items: list.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
