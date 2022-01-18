import 'package:flutter/material.dart';
import 'package:puzzle_test_12_1_2022/constants/strings.dart';
import 'package:puzzle_test_12_1_2022/data/cubit/public_cubit.dart';

class TilesContainer extends StatelessWidget {
  const TilesContainer({Key? key, required this.cubit}) : super(key: key);
  final PublicCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: cubit.listOfTiles!
          .asMap()
          .entries
          .map((e) => InkWell(
              onTap: () {
                cubit.replaceTilesAndVerifyWinOrNot(e.value);
              },
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: e.value.id != 16
                      ? Container(
                          key: ValueKey<int>(e.value.id!),
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: colors[e.value.color!],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25))),
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width / 5,
                          child: Center(
                              child: Text(
                            e.value.id.toString(),
                            style: textstyleTile,
                            key: ValueKey<int>(e.value.id!),
                          )),
                        )
                      : Container(
                          key: ValueKey<int>(e.value.id!),
                          margin: const EdgeInsets.all(3),
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width / 5,
                        ))))
          .toList(),
    );
  }
}
