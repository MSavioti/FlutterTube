import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:FlutterTube/blocs/favorites_bloc.dart';
import 'package:FlutterTube/blocs/videos_bloc.dart';
import 'package:FlutterTube/pages/home/home.dart';
import 'package:FlutterTube/pages/favorites/favorites.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
        bloc: FavoritesBloc(),
        child: MaterialApp(
          title: 'FlutterTube',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (context) => HomePage(),
            '/favorites': (context) => FavoritesPage(),
          },
        ),
      ),
    );
  }
}
