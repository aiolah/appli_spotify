import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_spotify_gorouter/models/SingleTrack.dart';

import '../models/SingleArtist.dart';
import '../providers/ArtistProvider.dart';
import '../providers/TrackProvider.dart';

// -- detail d'un artiste
class ResultArtistsScreen extends StatefulWidget {
  String? idArtist;

  /// Constructs a [ResultArtistsScreen]
  ResultArtistsScreen({super.key, this.idArtist});

  @override
  State<ResultArtistsScreen> createState() => _ResultArtistsScreen();
}

class _ResultArtistsScreen extends State<ResultArtistsScreen> {
  ArtistProvider artistProvider = ArtistProvider();
  TrackProvider trackProvider = TrackProvider();

  SingleArtist _artist = SingleArtist("", "", "", "", 0);
  List<SingleTrack> _tracks = [];

  @override
  void initState() {
    super.initState();
    _getSingleArtist();
    _getTracks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artiste Details Screen')),
      body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
        Image.network(_artist.image,
            fit: BoxFit.cover, width: 450, height: 400),
        Text(_artist.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text("Genres : ${_artist.genres}"),
        Text("Followers : ${_artist.followers.toString()}"),
        Text("All tracks of ${_artist.name}",
            style: TextStyle(fontWeight: FontWeight.bold)),
        ListView.builder(
            itemCount: _tracks.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              return (ListTile(
                  leading: const SizedBox(
                    width: 100,
                  ),
                  title: Text(_tracks[index].name)));
            },
            shrinkWrap: true)
      ]))
          // child: ElevatedButton(
          //   onPressed: () => context.go('/a/albumdetails'),
          //   child: const Text('Go back'),
          // ),
          ),
    );
  }

  void _getSingleArtist() async {
    SingleArtist theArtist = await artistProvider.getSingleArtist(widget.idArtist);

    setState(() {
      _artist = theArtist;
    });
  }

  void _getTracks() async {
    List<SingleTrack> tracks = await trackProvider.getTopTracks(widget.idArtist);

    setState(() {
      _tracks = tracks;
    });
  }
}
