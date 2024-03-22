import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/SingleTrack.dart';
import '../providers/TrackProvider.dart';

// The home screen
class SearchTracksScreen extends StatefulWidget {
  /// Constructs a [SearchTracksScreen]
  const SearchTracksScreen({super.key});

  @override
  State<SearchTracksScreen> createState() => _SearchTracksScreen();
}

class _SearchTracksScreen extends State<SearchTracksScreen> {
  TrackProvider trackProvider = TrackProvider();
  List<SingleTrack> _searchedTracks = [];

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Search a track')),
        body: Center(
            child: Column(children: [
          SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
            return SearchBar(
                controller: searchController,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {
                  // controller.openView();
                },
                onChanged: (_) {
                  // controller.openView();
                  if (searchController.text != "") {
                    _getSearchedTracks(searchController.text);
                  }
                },
                leading: const Icon(Icons.search));
          }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
              );
            });
          }),
          if (searchController.text.isNotEmpty)
            Expanded(
                child: ListView.builder(
                    itemCount: _searchedTracks.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int index) {
                      var idTrack = _searchedTracks[index].id;
                      return Card(
                        child: ListTile(
                          onTap: () => context
                              .go('/b/searchtracks/resultstracks/$idTrack'),
                          leading: SizedBox(
                            width: 100,
                            child: Image.network(_searchedTracks[index].image),
                          ),
                          title: Text(_searchedTracks[index].name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      );
                    }))
        ])));
  }

  void _getSearchedTracks(keyword) async {
    if (keyword != "") {
      List<SingleTrack> searchedTracks =
          await trackProvider.getSearchedTracks(keyword);

      setState(() {
        _searchedTracks = searchedTracks;
      });
    }
  }
}
