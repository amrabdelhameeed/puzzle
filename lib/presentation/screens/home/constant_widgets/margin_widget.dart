import 'package:flutter/material.dart';

class MarginWidget extends StatelessWidget {
  const MarginWidget(
      {Key? key, required this.isVertical, required this.dividedMargin})
      : super(key: key);
  final bool isVertical;
  final int dividedMargin;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isVertical
          ? MediaQuery.of(context).size.height / dividedMargin
          : null,
      width: !isVertical
          ? MediaQuery.of(context).size.width / dividedMargin
          : null,
    );
  }
}
