// Librairie pour faire des requêtes http
import 'package:http/http.dart' as http;
// Librairie pour faire du json_encode et du json_decode
import 'dart:convert';

import '../models/Album.dart';
import '../models/SingleAlbum.dart';

const urlApiDomain = "api.spotify.com";
const token =
    "BQAPYF3M0nvToHZjAIAc4DkixHnGoDJNkMOzSpXl9Nz_zN1YX1HB-k5F2tiKJZxSndEn0N6ZaozVIYCV1ELHDRinG2wtre-eGwiO1wSsccrJ_x42-vY";

class AlbumProvider {
  // Fonction de récupération de la liste des albums
  // https://api.spotify.com/v1/browse/new-releases?access_token=
  // https://api.spotify.com/v1/search?type=album&market=FR&q=shatter&access_token=
  Future<List<Album>> getAlbums(String keyword) async {
    var url;

    if (keyword != "") {
      var urlApiSpotify = "v1/search";
      var queryParameters = {"type": "album", "market": "FR", "q": keyword};
      url = Uri.https(urlApiDomain, urlApiSpotify, queryParameters);
    } else {
      var urlApiSpotify = "v1/browse/new-releases";
      url = Uri.https(urlApiDomain, urlApiSpotify);
    }

    var data = json.decode(
        (await http.get(url, headers: {"Authorization": "Bearer $token"}))
            .body);

    List<Album> listeAlbums = [];

    for (final album in data["albums"]["items"]) {
      // print(album);
      listeAlbums.add(Album.fromJson(album));
    }

    return listeAlbums;
  }

  // Fonction de récupération d'un album
  // https://api.spotify.com/v1/albums/0rlip3cEYFXL5BMUMTwb3N?access_token=
  Future<SingleAlbum> getAlbum(String? idAlbum) async {
    String urlApiSpotify = "v1/albums/$idAlbum";

    var url = Uri.https(urlApiDomain, urlApiSpotify);
    var data = json.decode(
        (await http.get(url, headers: {"Authorization": "Bearer $token"}))
            .body);

    SingleAlbum album = SingleAlbum.fromJson(data);

    return album;
  }
}
