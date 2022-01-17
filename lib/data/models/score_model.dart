class Score {
  int? moves;
  int? seconds;
  String? dateTime;
  Score({required this.dateTime, required this.moves, required this.seconds});

  Score.fromJson(Map<String, dynamic> map) {
    moves = map['moves'];
    seconds = map['seconds'];
    dateTime = map['dateTime'];
  }

  Map<String, dynamic> toJson() {
    return {'moves': moves, 'seconds': seconds, 'dateTime': dateTime};
  }
}
