import 'package:flutter/material.dart';

class AddVerticalSpace extends StatelessWidget {
  final double height;
  const AddVerticalSpace({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
