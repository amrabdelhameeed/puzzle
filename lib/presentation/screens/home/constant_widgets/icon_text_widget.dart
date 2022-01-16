import 'package:flutter/material.dart';

import 'custom_text_widget.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icons;
  final String text;

  const IconTextWidget({Key? key, required this.icons, required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(
            icons,
            size: 30,
          ),
          CustomTextWidget(fontSize: 20, text: text),
        ],
      ),
    );
  }
}
