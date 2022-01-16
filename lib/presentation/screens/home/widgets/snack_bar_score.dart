import 'package:flutter/material.dart';
import 'package:puzzle_test_12_1_2022/data/cubit/public_cubit.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/constant_widgets/custom_elevated_button.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/constant_widgets/custom_text_widget.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/widgets/moves_timer.dart';

class SnackBarScore extends StatelessWidget {
  SnackBarScore(
      {Key? key, required this.cubit, required this.state, required this.size})
      : super(key: key);
  final Size size;
  final PublicCubit cubit;
  final WinningState state;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      width: size.width,
      child: Column(
        children: [
          const Expanded(
            flex: 2,
            child: CustomTextWidget(
              fontSize: 25,
              text: "Well Done",
            ),
          ),
          Expanded(
            flex: 3,
            child: MovesTimer(
              cubit: cubit,
              moves: state.moves.toString(),
              seconds: state.seconds.toString(),
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomElevatedButton(
                onPressed: () {
                  cubit.generateNewTiles();
                  ScaffoldMessenger.of(context).clearSnackBars();
                },
                widget: const CustomTextWidget(
                  fontSize: 20,
                  text: "Play Again",
                )),
          )
        ],
      ),
    );
  }
}