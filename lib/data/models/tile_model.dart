import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TileModel {
  int? id;
  int? color;
  TileModel({
    required this.color,
    required this.id,
  });
  TileModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    color = map['color'];
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'color': color};
  }
}
