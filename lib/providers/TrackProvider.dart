// Librairie pour faire des requêtes http
import 'package:http/http.dart' as http;
// Librairie pour faire du json_encode et du json_decode
import 'dart:convert';

import '../models/SingleTrack.dart';
import '../models/SingleAlbum.dart';

const urlApiDomain = "api.spotify.com";
const token =
    "BQAPYF3M0nvToHZjAIAc4DkixHnGoDJNkMOzSpXl9Nz_zN1YX1HB-k5F2tiKJZxSndEn0N6ZaozVIYCV1ELHDRinG2wtre-eGwiO1wSsccrJ_x42-vY";

class TrackProvider {
  // https://api.spotify.com/v1/artists/0F01Y7t6Vim2IbJ2tSQnxa/top-tracks?access_token=
  Future<List<SingleTrack>> getTopTracks(String? idArtist) async {
    String urlApiSpotify = "v1/artists/$idArtist/top-tracks";

    var url = Uri.https(urlApiDomain, urlApiSpotify);
    var data = json.decode(
        (await http.get(url, headers: {"Authorization": "Bearer $token"}))
            .body);

    List<SingleTrack> listeTracks = [];

    for (final track in data["tracks"]) {
      listeTracks.add(SingleTrack.fromJson(track));
    }

    return listeTracks;
  }

  // https://api.spotify.com/v1/search?type=track&market=FR&q=shatter&access_token=
  Future<List<SingleTrack>> getSearchedTracks(keyword) async {
    String urlApiSpotify = "v1/search";

    var queryParameters = {"type": "track", "market": "FR", "q": keyword};
    var url = Uri.https(urlApiDomain, urlApiSpotify, queryParameters);
    var data = json.decode(
        (await http.get(url, headers: {"Authorization": "Bearer $token"}))
            .body);

    List<SingleTrack> listeTracks = [];

    for (final track in data["tracks"]["items"]) {
      listeTracks.add(SingleTrack.fromJson(track));
    }

    return listeTracks;
  }

  // https://api.spotify.com/v1/tracks/3nSglalUiJYQfUsnzvI5Px?access_token=
  Future<SingleTrack> getSingleTrack(String? idTrack) async {
    String urlApiSpotify = "v1/tracks/$idTrack";

    var url = Uri.https(urlApiDomain, urlApiSpotify);
    var data = json.decode(
        (await http.get(url, headers: {"Authorization": "Bearer $token"}))
            .body);

    SingleTrack track = SingleTrack.fromJson(data);

    return track;
  }
}
