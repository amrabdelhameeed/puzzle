import 'package:flutter/material.dart';
import 'package:puzzle_test_12_1_2022/data/cubit/public_cubit.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/constant_widgets/icon_text_widget.dart';

class MovesTimer extends StatelessWidget {
  MovesTimer({Key? key, required this.cubit, this.moves, this.seconds})
      : super(key: key);
  final PublicCubit cubit;
  String? seconds;
  String? moves;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconTextWidget(
            icons: Icons.timer_outlined,
            text: (seconds ?? cubit.seconds.toString()) + "  sec.s"),
        IconTextWidget(
            icons: Icons.directions_walk_outlined,
            text: moves ?? cubit.moves.toString())
      ],
    );
  }
}
