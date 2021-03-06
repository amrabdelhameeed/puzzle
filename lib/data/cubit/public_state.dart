part of 'public_cubit.dart';

@immutable
abstract class PublicState {}

class PublicInitial extends PublicState {}

class WinningState extends PublicState {
  final bool isWinning;
  final int moves;
  final int seconds;
  WinningState(this.isWinning, this.moves, this.seconds);
}

class PublicLoaded extends PublicState {}

class NewScoreCreated extends PublicState {}

class NewTileCreated extends PublicState {}

class DeleteAllScoresState extends PublicState {}
