import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:FlutterTube/shared/models/youtube_search_result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesBloc implements BlocBase {
  final _favoriteController =
      BehaviorSubject<Map<String, YouTubeSearchResult>>();
  Stream get outFavorites => _favoriteController.stream;
  Map<String, YouTubeSearchResult> _favorites = {};

  FavoritesBloc() {
    _favorites = _loadFavorites();
  }

  Map<String, YouTubeSearchResult> _loadFavorites() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains('favorites')) {
        return json.decode(prefs.getString('favorites')).map((key, value) {
          return MapEntry(key, YouTubeSearchResult.fromJson(value));
        }).cast<String, YouTubeSearchResult>();
      }
    });

    return {};
  }

  void saveFavorites() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('favorites', json.encode(_favorites));
      print(prefs.getString('favorites'));
    });
  }

  void toggleFavorite(YouTubeSearchResult searchResult) {
    if (isFavorite(searchResult)) {
      _favorites.remove(searchResult.id);
    } else {
      _favorites[searchResult.id] = searchResult;
    }

    _favoriteController.sink.add(_favorites);
    saveFavorites();
  }

  int favoritesCount() {
    if (_favorites == null) return 0;

    return _favorites.length;
  }

  bool isFavorite(YouTubeSearchResult searchResult) {
    return _favorites.containsKey(searchResult.id);
  }

  @override
  void dispose() {
    _favoriteController.close();
  }
}
