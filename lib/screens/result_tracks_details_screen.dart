import 'dart:html';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:just_audio/just_audio.dart';

import '../models/SingleTrack.dart';
import '../providers/TrackProvider.dart';

import '../providers/PlaylistProvider.dart';

/// The details screen
class ResultTracksScreen extends StatefulWidget {
  String? idTrack;

  /// Constructs a [ResultTracksScreen]
  ResultTracksScreen({super.key, this.idTrack});

  @override
  State<ResultTracksScreen> createState() => _ResultTracksScreen();
}

class _ResultTracksScreen extends State<ResultTracksScreen> {
  TrackProvider trackProvider = TrackProvider();
  SingleTrack _track = SingleTrack("", "", "", "", []);

  PlaylistProvider playlistProvider = PlaylistProvider();

  @override
  void initState() {
    super.initState();
    _getTrack();
  }

  // Player
  var player = AudioPlayer();
  var play = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Search Track Details Screen')),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: [
          Image.network(_track.image,
              fit: BoxFit.cover, width: 450, height: 400),
          Text(_track.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          // const SizedBox(height: 50),
          const Text("Artists", style: TextStyle(fontWeight: FontWeight.bold)),
          ListView.builder(
              itemCount: _track.artists.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return (ListTile(
                    leading: const SizedBox(
                      width: 100,
                    ),
                    title: Text(_track.artists[index])));
              },
              shrinkWrap: true),
          if (_track.previewUrl != "")
            if (play == true)
              ElevatedButton(
                  onPressed: () {
                    player.setAudioSource(AudioSource.uri(
                        Uri.parse(_track.previewUrl))); // url du fichier audio
                    player.play();
                    setState(() {
                      play = false;
                    });
                  },
                  child: const Text("PLAY"))
            else
              ElevatedButton(
                  onPressed: () {
                    player.pause();
                    setState(() {
                      play = true;
                    });
                  },
                  child: const Text("PAUSE")),
          if (_track.previewUrl != "")
            ElevatedButton(
                onPressed: () {
                  _addMusicPlaylist();
                },
                child: const Text("Add to playlist"))
        ]))));
  }

  void _getTrack() async {
    SingleTrack track = await trackProvider.getSingleTrack(widget.idTrack);

    setState(() {
      _track = track;
    });
  }

  void _addMusicPlaylist() async {
    await playlistProvider.open();
    await playlistProvider.addMusic(_track, _track.artists[0]);
  }
}
