import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../providers/PlaylistProvider.dart';
import 'package:projet_spotify_gorouter/models/TrackPlaylist.dart';

import 'package:just_audio/just_audio.dart';

// The home screen
class PlaylistScreen extends StatefulWidget {
  /// Constructs a [PlaylistScreen]
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreen();
}

class _PlaylistScreen extends State<PlaylistScreen> {
  PlaylistProvider playlistProvider = PlaylistProvider();
  List<TrackPlaylist> _playlist = [];

  var play = true;

  final player = AudioPlayer();
  final playlist = ConcatenatingAudioSource(
    useLazyPreparation: true,
    shuffleOrder: DefaultShuffleOrder(),
    children: [],
  );

  @override
  void initState() {
    super.initState();
    _getPlaylist();
  }

  // Détermine si l'audio est disponible | Si oui, on affiche l'icône Play
  Widget _playOrNot() {
    return IconButton(
      icon: _displayIcon(),
      onPressed: () {
        if (play == true) {
          player.play();
          setState(() {
            play = false;
          });
        } else {
          player.pause();
          setState(() {
            play = true;
          });
        }
      },
    );
  }

  // Détermine si on doit afficher l'icône Play ou l'icône Pause
  Widget _displayIcon() {
    if (play == true) {
      return Icon(Icons.play_circle_fill);
    } else {
      return Icon(Icons.pause_circle_filled);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('My Playlist')),
        body: Center(
            child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
                icon: Icon(Icons.skip_previous),
                onPressed: () {
                  player.seekToPrevious();
                }),
            IconButton(icon: _playOrNot(), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: () {
                  player.seekToNext();
                })
          ]),
          Expanded(
              child: ListView.builder(
                  itemCount: _playlist.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: ListTile(
                            // onTap: () => context.go('/a/albumdetails/$id'),
                            leading: SizedBox(
                              width: 100,
                              child: Image.network(_playlist[index].image),
                            ),
                            title: Text(_playlist[index].name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _deleteTrack(_playlist[index].id);
                                    _getPlaylist();
                                  });
                                })));
                  }))
        ])));
  }

  void _getPlaylist() async {
    await playlistProvider.open();

    List<TrackPlaylist> myPlaylist = [];
    myPlaylist = await playlistProvider.getMusics();

    for (final track in myPlaylist) {
      playlist.add(AudioSource.uri(Uri.parse(track.previewUrl)));
    }

    player.setAudioSource(playlist,
        initialIndex: 0, initialPosition: Duration.zero);

    setState(() {
      _playlist = myPlaylist;
    });
  }

  void _deleteTrack(int idMusic) async {
    await playlistProvider.open();

    int result = await playlistProvider.deleteMusic(idMusic);
    // print(result);
  }
}
