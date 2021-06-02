import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:FlutterTube/blocs/favorites_bloc.dart';
import 'package:FlutterTube/blocs/videos_bloc.dart';
import 'package:FlutterTube/delegates/search.dart';
import 'package:FlutterTube/shared/models/youtube_search_result.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size(double.infinity, 53.0);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoritesBloc>(context);
    return AppBar(
      title: Container(
        height: 36.0,
        child: Image.asset('assets/images/yt_logo.png'),
      ),
      elevation: 0.0,
      backgroundColor: Colors.black87,
      actions: [
        Align(
          alignment: Alignment.center,
          child: StreamBuilder<Map<String, YouTubeSearchResult>>(
              stream: bloc.outFavorites,
              builder: (context, snapshot) {
                return Text(
                  '${bloc.favoritesCount()}',
                  style: TextStyle(color: Colors.white70),
                );
              }),
        ),
        IconButton(
          icon: Icon(
            Icons.star,
            color: Colors.white70,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/favorites');
          },
        ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white70,
          ),
          onPressed: () async {
            String query =
                await showSearch(context: context, delegate: Search());
            if (query != null) {
              BlocProvider.of<VideosBloc>(context).inSearch.add(query);
            }
          },
        )
      ],
    );
  }
}
