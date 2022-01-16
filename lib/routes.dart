import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/strings.dart';
import 'data/cubit/public_cubit.dart';
import 'data/models/generate_tiles.dart';
import 'presentation/screens/home/home.dart';

class AppRouter {
  GeneratedTiles? generatedTiles;
  AppRouter() {
    generatedTiles = GeneratedTiles();
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) =>
                PublicCubit(generatedTiles: generatedTiles!)..tilesListCubit(),
            child: Home(),
          );
        });
    }
  }
}
