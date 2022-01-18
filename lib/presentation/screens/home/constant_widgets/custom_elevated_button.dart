import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget widget;
  const CustomElevatedButton(
      {Key? key, required this.onPressed, required this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: widget,
      style: ElevatedButton.styleFrom(
          primary: Colors.black,
          minimumSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.08)),
    );
  }
}
