import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final bool? isObSecure;
  final bool? autoFocus;
  final Widget? widget;

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  MyTextField({
    Key? key,
    this.hintText,
    this.initialValue,
    this.isObSecure,
    this.controller,
    this.onChanged,
    this.validator,
    this.autoValidateMode,
    this.keyboardType,
    this.textInputAction,
    this.autoFocus,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: TextFormField(
          enabled: keyboardType != TextInputType.url,
          autofocus: autoFocus ?? false,
          controller: controller,
          onChanged: onChanged,
          textInputAction: textInputAction ?? TextInputAction.next,
          enableSuggestions: true,
          validator: (value) => validator!(value),
          keyboardType: keyboardType ?? TextInputType.text,
          obscureText: isObSecure ?? false,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            hintText: hintText ?? "",
            suffixIcon: widget,
            hintStyle: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ),
      ),
    );
  }
}
