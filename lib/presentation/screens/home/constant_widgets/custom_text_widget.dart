import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({Key? key, required this.fontSize, required this.text})
      : super(key: key);
  final double fontSize;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Text(text,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: fontSize,
            )),
      ),
    );
  }
}
