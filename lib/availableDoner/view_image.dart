import 'package:flutter/material.dart';
import 'package:blood_donations/constant/constant.dart';

class ViewImage extends StatelessWidget {
  final String? path;
  const ViewImage({Key? key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: Image.network(
          path ?? imagePlaceHolder,
        ),
      ),
    );
  }
}
