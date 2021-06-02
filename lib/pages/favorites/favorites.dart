import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:FlutterTube/api.dart';
import 'package:FlutterTube/blocs/favorites_bloc.dart';
import 'package:FlutterTube/shared/models/youtube_search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoritesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, YouTubeSearchResult>>(
          stream: bloc.outFavorites,
          initialData: {},
          builder: (context, snapshot) {
            return ListView(
              children: snapshot.data.values.map((result) {
                return InkWell(
                  onTap: () {
                    FlutterYoutube.playYoutubeVideoById(
                        apiKey: apiKey, videoId: result.id);
                  },
                  onLongPress: () {
                    bloc.toggleFavorite(result);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 50,
                        child: Image.network(result.largeThumbnail),
                      ),
                      Expanded(
                        child: Text(
                          result.videoTitle,
                          style: TextStyle(color: Colors.white70),
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
