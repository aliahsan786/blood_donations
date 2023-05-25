import 'package:flutter/material.dart';
import 'package:blood_donations/constant/color.dart';

class MyButton extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  const MyButton({Key? key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: blueColor,
            borderRadius: BorderRadius.circular(10),
            // gradient: const LinearGradient(
            //   begin: Alignment.centerRight,
            //   end: Alignment.centerLeft,
            //   colors: [
            //     Colors.red,
            //     Colors.redAccent,
            //   ],
            // ),
          ),
          child: Center(
            child: Text(
              title ?? "",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MySmallButton extends StatelessWidget {
  final txt, onPressed, clr, width, txtColor;

  MySmallButton(
      {super.key,
      this.txt,
      this.onPressed,
      this.clr,
      this.width,
      this.txtColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: KSecondaryColor),
        color: clr,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        splashColor: Colors.transparent,
        onPressed: onPressed,
        child: Text(
          "$txt",
          style: TextStyle(
            color: txtColor ?? Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}

class MyButtonWithShawdo extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  const MyButtonWithShawdo({Key? key, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: blueColor,
            borderRadius: BorderRadius.circular(10),
            // gradient: const LinearGradient(
            //   begin: Alignment.centerRight,
            //   end: Alignment.centerLeft,
            //   colors: [
            //     Colors.red,
            //     Colors.redAccent,
            //   ],
            // ),
          ),
          child: Center(
            child: Text(
              title ?? "",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
