import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/Album.dart';
import '../providers/AlbumProvider.dart';

// The home screen
class SearchAlbumsScreen extends StatefulWidget {
  /// Constructs a [SearchAlbumsScreen]
  const SearchAlbumsScreen({super.key});

  @override
  State<SearchAlbumsScreen> createState() => _SearchAlbumsScreen();
}

class _SearchAlbumsScreen extends State<SearchAlbumsScreen> {
  AlbumProvider albumProvider = AlbumProvider();
  List<Album> _searchedAlbums = [];

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Search an album')),
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
                    _getSearchedAlbums(searchController.text);
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
                    itemCount: _searchedAlbums.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int index) {
                      var idAlbum = _searchedAlbums[index].id;
                      return Card(
                        child: ListTile(
                          onTap: () => context.go('/b/searchalbums/resultalbums/$idAlbum'),
                          leading: SizedBox(
                            width: 100,
                            child:
                                Image.network(_searchedAlbums[index].pochette),
                          ),
                          title: Text(_searchedAlbums[index].name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      );
                    }))
        ])));
  }

  void _getSearchedAlbums(keyword) async {
    if (keyword != "") {
      List<Album> searchedAlbums = await albumProvider.getAlbums(keyword);

      setState(() {
        _searchedAlbums = searchedAlbums;
      });
    }
  }
}
