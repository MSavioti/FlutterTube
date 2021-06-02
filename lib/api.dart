import 'dart:convert';
import 'package:FlutterTube/shared/models/youtube_search_response.dart';
import 'package:FlutterTube/shared/models/youtube_search_result.dart';
import 'package:http/http.dart' as http;

const String apiKey = 'INSERT_API_KEY';
const String searchBaseUri = 'https://www.googleapis.com/youtube/v3/search';
const String suggestionsBaseUri =
    'http://suggestqueries.google.com/complete/search?client=firefox&ds=yt&q=';
const String nextPageBaseUri =
    'https://www.googleapis.com/youtube/v3/search?part=snippet&q=';
const String targetTypeParameter = '&type=video&key=';
const String maxResultsParameter = '&maxResults=10';
const String pageTokenParameter = '&pageToken=';

class Api {
  Future<YouTubeSearchResponse> search(String query) async {
    http.Response response = await http.get(
        '$searchBaseUri?part=snippet&q=$query$targetTypeParameter$apiKey$maxResultsParameter');

    return decode(response);
  }

  Future<List<YouTubeSearchResult>> nextPage(String query, String token) async {
    http.Response response = await http.get(
        '$nextPageBaseUri$query$targetTypeParameter$apiKey$maxResultsParameter$pageTokenParameter$token');

    return decode(response).results;
  }

  Future<List> getSuggestions(String query) async {
    http.Response response = await http.get('$suggestionsBaseUri$query');
    return List.from(json.decode(response.body)[1]);
  }

  YouTubeSearchResponse decode(http.Response response) {
    if (response.statusCode != 200)
      throw Exception(
          'Failed to load video list. Status Code ${response.statusCode}');

    return YouTubeSearchResponse.fromJson(json.decode(response.body));
  }
}
