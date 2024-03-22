import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:projet_spotify_gorouter/models/ArtistFromAlbum.dart';
import 'package:projet_spotify_gorouter/providers/ArtistProvider.dart';

import 'package:just_audio/just_audio.dart';

import '../providers/AlbumProvider.dart';
import '../models/Album.dart';
import '../models/SingleAlbum.dart';

/// The details screen
class AlbumDetailScreen extends StatefulWidget {
  String? idAlbum;

  /// Constructs a [AlbumDetailScreen]
  AlbumDetailScreen({super.key, this.idAlbum});

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreen();
}

class _AlbumDetailScreen extends State<AlbumDetailScreen> {
  AlbumProvider albumProvider = AlbumProvider();
  SingleAlbum _album = SingleAlbum("", "", "", "", "", []);

  ArtistProvider artistProvider = ArtistProvider();
  List<ArtistFromAlbum> _artistsFromAlbum = [];

  @override
  void initState() {
    super.initState();
    _getInfosAlbum();
  }

  var player = AudioPlayer();
  var play = true;

  // Détermine si l'audio est disponible | Si oui, on affiche l'icône Play
  Widget? _playOrNot(track) {
    if (track.previewUrl != "") {
      return IconButton(
        icon: _displayIcon(track),
        onPressed: () {
          if (track.play == true) {
            player.setAudioSource(AudioSource.uri(
                Uri.parse(track.previewUrl))); // url du fichier audio
            player.play();
            setState(() {
              track.play = false;
            });
          } else {
            player.pause();
            setState(() {
              track.play = true;
            });
          }
        },
      );
    }
  }

  // Détermine si on doit afficher l'icône Play ou l'icône Pause
  Widget _displayIcon(track) {
    if (track.play == true) {
      return Icon(Icons.play_circle_fill);
    } else {
      return Icon(Icons.pause_circle_filled);
    }
  }

  // -- detail d'un album
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Album Details Screen')),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: [
          Image.network(_album.pochette,
              fit: BoxFit.cover, width: 450, height: 400),
          Text(_album.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          // const SizedBox(height: 50),
          const Text("Tracks", style: TextStyle(fontWeight: FontWeight.bold)),
          ListView.builder(
              itemCount: _album.tracks.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return (ListTile(
                    leading: const SizedBox(
                      width: 100,
                    ),
                    title: Text(_album.tracks[index].name),
                    trailing: _playOrNot(_album.tracks[index])));
              },
              shrinkWrap: true),
          // const SizedBox(height: 50),
          const Text("Artists", style: TextStyle(fontWeight: FontWeight.bold)),
          ListView.builder(
              itemCount: _artistsFromAlbum.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return (ListTile(
                  leading: const SizedBox(
                    width: 100,
                  ),
                  onTap: () => context
                      .go('/a/artistedetails/${_artistsFromAlbum[index].id}'),
                  title: Text(_artistsFromAlbum[index].name),
                ));
              },
              shrinkWrap: true)
        ]))));
  }

  void _getInfosAlbum() async {
    SingleAlbum album = await albumProvider.getAlbum(widget.idAlbum);
    List<ArtistFromAlbum> artistsFromAlbum =
        await artistProvider.getArtistsFromAlbum(widget.idAlbum);

    setState(() {
      _album = album;
      _artistsFromAlbum = artistsFromAlbum;
    });
  }
}
