import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:puzzle_test_12_1_2022/data/models/score_model.dart';
import 'package:puzzle_test_12_1_2022/database/database_helper_for_list_of_tiles.dart';
import 'package:puzzle_test_12_1_2022/database/database_helper_for_score.dart';
import '../models/generate_tiles.dart';
import '../models/tile_model.dart';
part 'public_state.dart';

class PublicCubit extends Cubit<PublicState> {
  PublicCubit({required this.generatedTiles}) : super(PublicInitial());
  final GeneratedTiles generatedTiles;
  static PublicCubit get(context) => BlocProvider.of(context);
  List<TileModel>? listOfTiles;
  Timer? timer;
  int seconds = 0;
  int moves = 0;

  void generateTilesforTest() {
    listOfTiles = GeneratedTiles().generatedTiles();
    timerFun(TimerModes.stop);
    timerFun(TimerModes.start);
    emit(WinningState(false, seconds, moves));
  }

  void generateNewTiles() {
    timerFun(TimerModes.stop);
    listOfTiles = tilesListCubit();
    pressSaveTiles();
  }

//fun to know if the user won or not
  void isListsEqual(List<TileModel> list) {
    int s = 0;
    for (int i = 0; i < listOfTiles!.length; i++) {
      if (i != list[i].id! - 1) {
        s = i;
      }
    }
    if (s == 0) {
      emit(WinningState(true, moves, seconds));
      createScore(moves: moves, seconds: seconds);
    }
  }

  void timerFun(TimerModes timerModes) {
    timerModes == TimerModes.start
        ? timer = Timer.periodic(const Duration(seconds: 1), (t) {
            seconds++;
            // if (seconds % 15 == 0) {
            //   pressSaveTiles();
            // }
            emit(PublicLoaded());
          })
        : {timer!.cancel(), seconds = 0, moves = 0};
  }

  List<TileModel> tilesListCubit() {
    listOfTiles = generatedTiles.generatedTiles();
    listOfTiles!.shuffle();
    moves = 0;
    if (timer != null) {
      timerFun(TimerModes.stop);
    }
    timerFun(TimerModes.start);
    emit(PublicLoaded());
    return listOfTiles!;
  }

  void swap(int a, int b) {
    final temp = listOfTiles![a];
    listOfTiles![a] = listOfTiles![b];
    listOfTiles![b] = temp;
  }

  void replaceTilesAndVerifyWinOrNot(TileModel tileModel) {
    int indexOfMovingTile =
        listOfTiles!.indexWhere((element) => element.id == 16);
    int indexOfPressedTile =
        listOfTiles!.indexWhere((element) => element.id == tileModel.id);
    int sum = indexOfMovingTile - indexOfPressedTile;
    sum = sqrt(sum * sum).toInt(); //to get only positive values
    if (tileModel.id != 16) {
      if (sum == 1) {
        if (indexOfPressedTile > indexOfMovingTile &&
            indexOfPressedTile % 4 != 0) {
          swap(indexOfMovingTile, indexOfPressedTile);
          moves++;
        } else if (indexOfPressedTile < indexOfMovingTile &&
            indexOfMovingTile % 4 != 0) {
          swap(indexOfMovingTile, indexOfPressedTile);
          moves++;
        }
      } else if (sum % 4 == 0) {
        if (sum == 4) {
          swap(indexOfMovingTile, indexOfPressedTile);
          moves++;
        } else if (sum == 8) {
          if (indexOfPressedTile > indexOfMovingTile) {
            swap(indexOfMovingTile, indexOfMovingTile + 4);
            swap(indexOfMovingTile + 4, indexOfMovingTile + 8);
            moves++;
          } else {
            swap(indexOfMovingTile, indexOfMovingTile - 4);
            swap(indexOfMovingTile - 4, indexOfMovingTile - 8);
            moves++;
          }
        } else if (sum == 12) {
          if (indexOfPressedTile > indexOfMovingTile) {
            swap(indexOfMovingTile, indexOfMovingTile + 4);
            swap(indexOfMovingTile + 4, indexOfMovingTile + 8);
            swap(indexOfMovingTile + 8, indexOfMovingTile + 12);
            moves++;
          } else {
            swap(indexOfMovingTile, indexOfMovingTile - 4);
            swap(indexOfMovingTile - 4, indexOfMovingTile - 8);
            swap(indexOfMovingTile - 8, indexOfMovingTile - 12);
            moves++;
          }
        }
      } else if (sum == 2) {
        if (indexOfMovingTile < indexOfPressedTile &&
            (indexOfMovingTile + 1) % 4 != 0 &&
            (indexOfMovingTile + 2) % 4 != 0) {
          swap(indexOfMovingTile, indexOfMovingTile + 1);
          swap(indexOfMovingTile + 1, indexOfMovingTile + 2);
          moves++;
        } else if (indexOfMovingTile > indexOfPressedTile &&
            (indexOfPressedTile + 1) % 4 != 0 &&
            (indexOfPressedTile + 2) % 4 != 0) {
          swap(indexOfMovingTile, indexOfMovingTile - 1);
          swap(indexOfMovingTile - 1, indexOfMovingTile - 2);
          moves++;
        }
      } else if (sum == 3) {
        if ((indexOfMovingTile % 4 == 0) &&
            indexOfMovingTile < indexOfPressedTile) {
          swap(indexOfMovingTile, indexOfMovingTile + 1);

          swap(indexOfMovingTile + 1, indexOfMovingTile + 2);

          swap(indexOfMovingTile + 2, indexOfMovingTile + 3);
          moves++;
        } else if ((indexOfPressedTile % 4 == 0) &&
            indexOfMovingTile > indexOfPressedTile) {
          swap(indexOfMovingTile, indexOfMovingTile - 1);

          swap(indexOfMovingTile - 1, indexOfMovingTile - 2);

          swap(indexOfMovingTile - 2, indexOfMovingTile - 3);
          moves++;
        }
      }
    }

    emit(PublicLoaded());
    isListsEqual(listOfTiles!);
  }

  List<Score> users = [];
  ///// data base functions
  DBhelper db = DBhelper.instance;
  Future<List<Score>> getAllScores() async {
    var dba = DBhelper.instance;
    await dba.getAllscores().then((value) {
      users = [];
      value.asMap().forEach((i, value) {
        if (i < 9) {
          users.add(value);
        }
      });
    });
    return users;
  }

  // void initDb() {
  //   getAllScores().then((value) {
  //           users = value;
  //   });
  // }

  void createScore({required int moves, required int seconds}) {
    db.createscore(Score(
        dateTime: DateTime.now().toString(), moves: moves, seconds: seconds));
    emit(NewScoreCreated());
    getAllScores();
  }

  void deleteAllScores() {
    db.deleteAllscores();
    emit(DeleteAllScoresState());
    db = DBhelper.instance;
    getAllScores();
  }

  // db for tiles

  ///// data base functions
  DBhelperForTiles db2 = DBhelperForTiles.instance;
  Future<List<TileModel>> getAlltilesCubit() async {
    var dba = DBhelperForTiles.instance;
    listOfTiles = [];
    moves = 0;
    timerFun(TimerModes.start);
    await dba.getAlltiles().then((value) {
      value.asMap().forEach((i, value) {
        listOfTiles!.add(value);
      });
      listOfTiles!.isNotEmpty
          ? {seconds = listOfTiles!.last.id!, moves = listOfTiles!.last.color!}
          : null;
    });
    listOfTiles!.isNotEmpty
        ? {listOfTiles!.removeAt(listOfTiles!.length - 1)}
        : null;
    emit(NewTileCreated());

    return listOfTiles!.isEmpty ? tilesListCubit() : listOfTiles!;
  }

  // void initDb() {
  //   getAllScores().then((value) {
  //           users = value;
  //   });
  // }

  void createTile({required int id, required int color}) {
    db2 = DBhelperForTiles.instance;
    db2.createtile(TileModel(id: id, color: color));
    emit(NewScoreCreated());
    //  getAlltilesCubit();
  }

  void deleteAlltiles() {
    db2.deleteAllTileModels();
    emit(DeleteAllScoresState());
    db2 = DBhelperForTiles.instance;
    emit(NewTileCreated());

    //  getAlltilesCubit();
  }

  void storeAllListOfTiles() {
    db2 = DBhelperForTiles.instance;
    listOfTiles!.forEach((element) {
      createTile(id: element.id!, color: element.color!);
    });
    createTile(id: seconds, color: moves);
    emit(NewTileCreated());
  }

  void opendb() {
    db2 = DBhelperForTiles.instance;
    getAlltilesCubit();
    emit(NewTileCreated());
  }

  void pressSaveTiles() {
    // db2 = DBhelperForTiles.instance;
    // deleteAlltiles();
    db2 = DBhelperForTiles.instance;
    deleteAlltiles();
    storeAllListOfTiles();
    emit(NewTileCreated());
    print(listOfTiles!.first.id);
  }
}

enum TimerModes {
  start,
  stop,
}
