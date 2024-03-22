import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/SingleArtist.dart';
import '../providers/ArtistProvider.dart';

// The home screen
class SearchArtistsScreen extends StatefulWidget {
  /// Constructs a [SearchArtistsScreen]
  const SearchArtistsScreen({super.key});

  @override
  State<SearchArtistsScreen> createState() => _SearchArtistsScreen();
}

class _SearchArtistsScreen extends State<SearchArtistsScreen> {
  ArtistProvider artistProvider = ArtistProvider();
  List<SingleArtist> _searchedArtists = [];

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Search an artist')),
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
                    itemCount: _searchedArtists.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int index) {
                      var idArtist = _searchedArtists[index].id;
                      return Card(
                        child: ListTile(
                          onTap: () => context
                              .go('/b/searchartists/resultsartists/$idArtist'),
                          leading: SizedBox(
                            width: 100,
                            child: Image.network(_searchedArtists[index].image),
                          ),
                          title: Text(_searchedArtists[index].name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      );
                    }))
        ])));
  }

  void _getSearchedTracks(keyword) async {
    if (keyword != "") {
      List<SingleArtist> searchedArtists =
          await artistProvider.getSearchedArtists(keyword);

      setState(() {
        _searchedArtists = searchedArtists;
      });
    }
  }
}
