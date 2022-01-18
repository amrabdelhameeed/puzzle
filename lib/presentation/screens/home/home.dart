import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_test_12_1_2022/constants/strings.dart';
import 'package:puzzle_test_12_1_2022/data/models/score_model.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/constant_widgets/custom_elevated_button.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/constant_widgets/custom_text_widget.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/constant_widgets/margin_widget.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/widgets/moves_timer.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/widgets/my_drawer.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/widgets/snack_bar_score.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/widgets/tiles_container.dart';
import '../../../data/cubit/public_cubit.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<PublicCubit, PublicState>(
      listener: (context, state) {
        var cubit = PublicCubit.get(context);
        if (state is WinningState) {
          if (state.isWinning) {
            cubit.timerFun(TimerModes.stop);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(hours: 1),
                content: SnackBarScore(
                    cubit: cubit,
                    seconds: state.seconds,
                    firstScore: cubit.users.isNotEmpty
                        ? cubit.users.first
                        : Score(
                            dateTime: DateTime.now().toString(),
                            moves: 100000,
                            seconds: 100000),
                    moves: state.moves,
                    size: size)));
          }
        }
      },
      builder: (context, state) {
        var cubit = PublicCubit.get(context);
        return SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            drawer: MyDrawer(cubit: cubit),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                tooltip: "Score Board",
                                onPressed: () {
                                  scaffoldKey.currentState!.openDrawer();
                                },
                                icon: const Icon(
                                  Icons.list,
                                  size: 30,
                                )),
                            const CustomTextWidget(
                              fontSize: 40,
                              text: "Puzzle",
                            ),
                          ],
                        ),
                        IconButton(
                            tooltip: "Save the current game",
                            onPressed: () {
                              cubit.pressSaveTiles();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      duration: Duration(
                                        seconds: 1,
                                      ),
                                      content: SizedBox(
                                        height: 30,
                                        child: Center(
                                            child: Text(
                                          "Saved !",
                                          style: TextStyle(fontSize: 30),
                                        )),
                                      )));
                            },
                            icon: const Icon(
                              Icons.save_rounded,
                              size: 32,
                            ))
                      ],
                    ),
                    TilesContainer(cubit: cubit),
                    MovesTimer(cubit: cubit),
                    CustomElevatedButton(
                        onPressed: () {
                          cubit.generateNewTiles();
                        },
                        widget: const CustomTextWidget(
                          fontSize: 25,
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
