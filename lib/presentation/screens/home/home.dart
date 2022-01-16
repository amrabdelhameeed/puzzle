import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/constant_widgets/custom_elevated_button.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/constant_widgets/custom_text_widget.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/widgets/moves_timer.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/widgets/snack_bar_score.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/widgets/tiles_container.dart';
import '../../../data/cubit/public_cubit.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<PublicCubit, PublicState>(
      listener: (context, state) {
        var cubit = PublicCubit.get(context);
        if (state is WinningState) {
          if (state.isWinning) {
            cubit.timerFun(TimerModes.stop);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(hours: 1),
                content:
                    SnackBarScore(cubit: cubit, state: state, size: size)));
          }
        }
      },
      builder: (context, state) {
        var cubit = PublicCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    const CustomTextWidget(
                      fontSize: 40,
                      text: "Puzzle",
                    ),
                    TilesContainer(cubit: cubit),
                    MovesTimer(cubit: cubit),
                    CustomElevatedButton(
                        onPressed: () {
                          cubit.generateNewTiles();
                        },
                        widget: const CustomTextWidget(
                          fontSize: 20,
                          text: "Shuffle Tiles",
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
