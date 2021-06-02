import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:FlutterTube/api.dart';
import 'package:FlutterTube/blocs/favorites_bloc.dart';
import 'package:FlutterTube/shared/models/youtube_search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class VideoTile extends StatelessWidget {
  const VideoTile({Key key, this.searchResult}) : super(key: key);

  final YouTubeSearchResult searchResult;
  static const int videoTitleMaxLines = 2;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoritesBloc>(context);
    return GestureDetector(
      onTap: () {
        FlutterYoutube.playYoutubeVideoById(
            apiKey: apiKey, videoId: searchResult.id);
      },
      child: Container(
        color: Colors.black87,
        margin: EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Image.network(
                searchResult.largeThumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                        child: Text(
                          searchResult.videoTitle,
                          maxLines: videoTitleMaxLines,
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          searchResult.channel,
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Map<String, YouTubeSearchResult>>(
                  initialData: {},
                  stream: bloc.outFavorites,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.red[700]),
                      );
                    }

                    return IconButton(
                      icon: Icon(
                        bloc.isFavorite(searchResult)
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.white70,
                        size: 32.0,
                      ),
                      onPressed: () {
                        bloc.toggleFavorite(searchResult);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
