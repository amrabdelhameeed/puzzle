import 'package:flutter/material.dart';
import 'package:puzzle_test_12_1_2022/data/cubit/public_cubit.dart';
import 'package:puzzle_test_12_1_2022/data/models/score_model.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/constant_widgets/custom_elevated_button.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/constant_widgets/custom_text_widget.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/widgets/moves_timer.dart';

class SnackBarScore extends StatelessWidget {
  const SnackBarScore(
      {Key? key,
      required this.cubit,
      required this.seconds,
      required this.moves,
      required this.firstScore,
      required this.size})
      : super(key: key);
  final Size size;
  final PublicCubit cubit;
  final int seconds;
  final int moves;
  final Score firstScore;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.3,
      width: size.width,
      child: Column(
        children: [
          CustomTextWidget(
            fontSize: 25,
            text: "Well Done",
          ),
          (firstScore.moves! + firstScore.seconds! > moves + seconds)
              ? CustomTextWidget(
                  fontSize: 25,
                  text: "New High Score !",
                )
              : const SizedBox(),
          MovesTimer(
            cubit: cubit,
            moves: moves.toString(),
            seconds: seconds,
          ),
          CustomElevatedButton(
              onPressed: () {
                cubit.generateNewTiles();
                ScaffoldMessenger.of(context).clearSnackBars();
              },
              widget: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Play Again",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
