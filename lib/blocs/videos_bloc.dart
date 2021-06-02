import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:FlutterTube/api.dart';
import 'package:FlutterTube/shared/models/youtube_search_response.dart';

class VideosBloc implements BlocBase {
  Api api;
  YouTubeSearchResponse youTubeResponse;
  final _videosController = StreamController<YouTubeSearchResponse>();
  Stream get outVideos => _videosController.stream;
  final _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    api = Api();
    _searchController.stream.listen(_search);
  }

  void _search(String query) async {
    if (query != null) {
      _videosController.sink.add(null);
      youTubeResponse = await api.search(query);
    } else {
      final token = youTubeResponse.nextPageToken;
      youTubeResponse.results += await api.nextPage(query, token);
    }

    _videosController.sink.add(youTubeResponse);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}
