import 'package:flutter/material.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:blood_donations/constant/style.dart';

class MyDateFormField extends StatelessWidget {
  final String? hintText;

  final TextEditingController? controller;

  final Function()? onTap;

  const MyDateFormField({Key? key, this.controller, this.hintText, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 3),
          suffixIcon: const Icon(Icons.date_range_outlined),
          labelText: hintText ?? "",
          labelStyle: normalStyle,
        ),
        readOnly: true,
        onTap: onTap,
        // onTap: () async {
        //   DateTime? pickedDate = await showDatePicker(
        //     context: context,
        //     initialDate: DateTime.now(),
        //     firstDate: DateTime(1950),
        //     lastDate: DateTime.now(),
        //   );
        //
        //   if (pickedDate != null) {
        //     controller?.text = DateFormat.yMMMd().format(pickedDate);
        //   } else {
        //     validator!(pickedDate);
        //   }
        // },
      ),
    );
  }
}

//
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:flutter/material.dart';
// import 'package:nikah_match/constants/color_style_constant.dart';
// import 'package:nikah_match/constants/controllers.dart';
// import 'package:intl/intl.dart';
//
// class MyDatePicker extends StatelessWidget {
//   final Future<DateTime?> onShowPicker;
//   MyDatePicker({Key? key, required this.onShowPicker}) : super(key: key);
//   final format = DateFormat("yyyy-MM-dd");
//   Color dobLabel = kPrimaryColor.withOpacity(0.5);
//
//   dateFieldValidator(DateTime date) {
//     if (date == null) {
//       return 'Selecting a date is required';
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DateTimeField(
//         format: format,
//         controller: authController.birthDate,
//         style: CustomInputDecoration.textStyle,
//         validator: (val) => dateFieldValidator(val ?? DateTime.now()),
//         decoration: InputDecoration(
//           enabledBorder: CustomInputDecoration.border,
//           focusedBorder: CustomInputDecoration.focusBorder,
//           errorBorder: CustomInputDecoration.errorBorder,
//           focusedErrorBorder: CustomInputDecoration.errorBorder,
//           suffixIcon: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/new_images/calendar.png',
//                 height: 17,
//                 color: kTransparentColor,
//               ),
//             ],
//           ),
//           labelText: 'Birth of Date',
//           hintStyle: CustomInputDecoration.hintStyle,
//           labelStyle: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: dobLabel,
//           ),
//           contentPadding: CustomInputDecoration.padding,
//         ),
//         onShowPicker: (context, currentValue) => onShowPicker);
//   }
// }

// //+++
// DateTimeField(
// format: format,
// style: CustomInputDecoration.fixStyle,
// controller: authController.birthDate,
// cursorColor: kBlackColor,
// initialValue: DateTime.parse(authController.birthDate.text),
// validator: (val) => dateFieldValidator(val ?? DateTime.now()),
// decoration: InputDecoration(
// suffixIcon: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Image.asset(
// 'assets/new_images/calendar.png',
// height: 20,
// color: kBlackColor.withOpacity(0.30),
// ),
// ],
// ),
// hintText: "Birth date",
// labelText: 'Birth of Date',
// contentPadding: CustomInputDecoration.padding,
// hintStyle: CustomInputDecoration.fixStyle,
// labelStyle: CustomInputDecoration.fixLabelStyle,
// enabledBorder: CustomInputDecoration.fixBorder,
// focusedBorder: CustomInputDecoration.fixBorder,
// errorBorder: CustomInputDecoration.errorBorder,
// focusedErrorBorder: CustomInputDecoration.errorBorder,
// ),
// onShowPicker: (context, currentValue) {
// return showDatePicker(
// context: context,
// firstDate: DateTime(1900),
// initialDate: DateTime.parse(authController.birthDate.text),
// lastDate: DateTime(DateTime.now().year - 16),
// );
// },
// ),
