import 'package:flutter/material.dart';
import 'package:puzzle_test_12_1_2022/data/cubit/public_cubit.dart';
import 'package:puzzle_test_12_1_2022/data/models/score_model.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/constant_widgets/custom_elevated_button.dart';

List<Score> generateList(BuildContext context, PublicCubit cubit) {
  List<Score> list = cubit.users;
  list.toSet();
  return list;
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key, required this.cubit}) : super(key: key);
  final PublicCubit cubit;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                "Score Board",
                style: TextStyle(
                    fontSize: size.height * 0.03, fontWeight: FontWeight.w700),
              ),
            ),
            Column(
              children: generateList(context, cubit)
                  .map((s) => Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        height: 80,
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "duration: " +
                                          (Duration(
                                                  seconds: int.parse(
                                                      s.seconds.toString()))
                                              .toString()
                                              .substring(0, 7)),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 21),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "moves : " + s.moves.toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 21),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "date : " +
                                          s.dateTime
                                              .toString()
                                              .substring(0, 10),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "time : " +
                                          s.dateTime
                                              .toString()
                                              .substring(11, 16),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            cubit.users.isNotEmpty
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onPressed: () {
                        cubit.deleteAllScores();
                      },
                      widget: Text("delete all Scores"),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
