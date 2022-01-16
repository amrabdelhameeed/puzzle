import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
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
  }

//fun to know if the user won or not
  void isListsEqual(List<TileModel> list) {
    int s = 0;
    for (var i = 0; i < listOfTiles!.length; i++) {
      if (i != list[i].id! - 1) {
        s = i;
      }
    }
    if (s == 0) {
      emit(WinningState(true, moves, seconds));
    }
  }

  void timerFun(TimerModes timerModes) {
    timerModes == TimerModes.start
        ? timer = Timer.periodic(const Duration(seconds: 1), (t) {
            seconds++;
            emit(PublicLoaded(listOfTiles!));
          })
        : {timer!.cancel(), seconds = 0, moves = 0};
  }

  List<TileModel> tilesListCubit() {
    listOfTiles = generatedTiles.generatedTiles();
    listOfTiles!.shuffle();
    //   timerFun(0);
    moves = 0;
    timerFun(TimerModes.start);
    emit(PublicLoaded(listOfTiles!));
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
    if (tileModel.id != 16 && (((sum == 1)) || sum == 4)) {
      if (indexOfPressedTile - indexOfMovingTile == 1 &&
              indexOfPressedTile % 4 == 0 ||
          indexOfMovingTile - indexOfPressedTile == 1 &&
              indexOfMovingTile % 4 == 0) {
      } else {
        swap(indexOfMovingTile, indexOfPressedTile);
        moves++;
      }
    }
    emit(PublicLoaded(listOfTiles!));
    isListsEqual(listOfTiles!);
  }
}

enum TimerModes {
  start,
  stop,
}