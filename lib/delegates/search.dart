import 'package:FlutterTube/api.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.black87,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      close(context, query);
    });

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    final api = Api();

    return FutureBuilder<List>(
      future: api.getSuggestions(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(snapshot.data[i]),
                onTap: () {
                  close(context, snapshot.data[i]);
                },
              );
            });
      },
    );
  }
}
