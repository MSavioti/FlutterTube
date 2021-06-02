import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:FlutterTube/blocs/videos_bloc.dart';
import 'package:FlutterTube/pages/home/widgets/home_appbar.dart';
import 'package:FlutterTube/pages/home/widgets/video_tile.dart';
import 'package:FlutterTube/shared/models/youtube_search_response.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideosBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: HomeAppBar(),
      body: HomeBody(bloc: bloc),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final VideosBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<YouTubeSearchResponse>(
        stream: bloc.outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final results = snapshot.data.results;
            return ListView.builder(
              itemCount: results.length + 1,
              itemBuilder: (context, index) {
                if (index >= results.length) {
                  bloc.inSearch.add(null);
                  return Container(
                    height: 40.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.red[700]),
                    ),
                  );
                }

                return VideoTile(
                  searchResult: results[index],
                );
              },
            );
          }
          return Container(
            color: Colors.black,
            child: Center(
                child: Icon(
              Icons.search,
              color: Colors.grey[900],
            )),
          );
        });
  }
}
