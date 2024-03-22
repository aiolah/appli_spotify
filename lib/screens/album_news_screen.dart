import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../providers/AlbumProvider.dart';
import '../models/Album.dart';

// -- les derniers albums (news)
class AlbumNewsScreen extends StatefulWidget {
  /// Constructs a [AlbumNewsScreen]
  const AlbumNewsScreen({super.key});

  @override
  State<AlbumNewsScreen> createState() => _AlbumNewsScreen();
}

class _AlbumNewsScreen extends State<AlbumNewsScreen> {
  AlbumProvider albumProvider = AlbumProvider();
  List<Album> _listeAlbums = [];

  // On ne peut pas utiliser la méthode fetchAlbums() ici car c'est une fonction asynchrone et le initState est synchrone. Et surtout, on ne peut pas changer son type puisqu'on l'override
  @override
  void initState() {
    super.initState();
    _getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Album News Screen')),
        body: ListView.builder(
            itemCount: _listeAlbums.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              var id = _listeAlbums[index].id;

              return Card(
                child: ListTile(
                  onTap: () => context.go('/a/albumdetails/$id'),
                  leading: SizedBox(
                    width: 100,
                    child: Image.network(_listeAlbums[index].pochette),
                  ),
                  title: Text(_listeAlbums[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              );
            }));
    // child: ElevatedButton(
    //   onPressed: () => context.go('/a/albumdetails'),
    //   child: const Text('Go to the Details screen'),
    // ),
  }

  void _getAlbums() async {
    List<Album> listeAlbums = await albumProvider.getAlbums("");
    // print(listeAlbums);
    setState(() {
      _listeAlbums.addAll(listeAlbums);
    });
  }
}
