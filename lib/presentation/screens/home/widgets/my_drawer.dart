import 'package:flutter/material.dart';
import 'package:puzzle_test_12_1_2022/data/cubit/public_cubit.dart';
import 'package:puzzle_test_12_1_2022/data/models/score_model.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/constant_widgets/custom_elevated_button.dart';
import 'package:puzzle_test_12_1_2022/presentation/screens/home/home.dart';

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
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Text("Score Board :"),
            ),
            Column(
              children: generateList(context, cubit)
                  .map((s) => SizedBox(
                        height: 80,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "moves : " + s.moves.toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  "seconds :" + s.seconds.toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "date : " +
                                      s.dateTime.toString().substring(0, 10),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  "time :" +
                                      s.dateTime.toString().substring(11, 16),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            cubit.users.isNotEmpty
                ? Container(
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
