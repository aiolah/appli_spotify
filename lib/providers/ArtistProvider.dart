// Librairie pour faire des requêtes http
import 'package:http/http.dart' as http;
import 'package:projet_spotify_gorouter/models/ArtistFromAlbum.dart';
// Librairie pour faire du json_encode et du json_decode
import 'dart:convert';

import '../models/ArtistFromAlbum.dart';
import '../models/SingleArtist.dart';

const urlApiDomain = "api.spotify.com";
const token =
    "BQAPYF3M0nvToHZjAIAc4DkixHnGoDJNkMOzSpXl9Nz_zN1YX1HB-k5F2tiKJZxSndEn0N6ZaozVIYCV1ELHDRinG2wtre-eGwiO1wSsccrJ_x42-vY";

class ArtistProvider {
  // https://api.spotify.com/v1/albums/0rlip3cEYFXL5BMUMTwb3N?access_token=
  Future<List<ArtistFromAlbum>> getArtistsFromAlbum(String? idAlbum) async {
    String urlApiSpotify = "v1/albums/$idAlbum";

    var url = Uri.https(urlApiDomain, urlApiSpotify);
    var data = json.decode(
        (await http.get(url, headers: {"Authorization": "Bearer $token"}))
            .body);

    List<ArtistFromAlbum> list = [];
    for (var i = 0; i < data["artists"].length; i++) {
      list.add(ArtistFromAlbum.fromJson(data["artists"][i]));
    }

    return list;
  }

  // Fonction de récupération d'un artist
  // https://api.spotify.com/v1/artists/0F01Y7t6Vim2IbJ2tSQnxa?access_token=
  Future<SingleArtist> getSingleArtist(String? idArtist) async {
    String urlApiSpotify = "v1/artists/$idArtist";

    var url = Uri.https(urlApiDomain, urlApiSpotify);
    var data = json.decode(
        (await http.get(url, headers: {"Authorization": "Bearer $token"}))
            .body);

    SingleArtist artist = SingleArtist.fromJson(data);

    return artist;
  }

  // https://api.spotify.com/v1/search?type=artist&market=FR&q=shatter&access_token=
  Future<List<SingleArtist>> getSearchedArtists(keyword) async {
    String urlApiSpotify = "v1/search";

    var queryParameters = {"type": "artist", "market": "FR", "q": keyword};
    var url = Uri.https(urlApiDomain, urlApiSpotify, queryParameters);
    var data = json.decode(
        (await http.get(url, headers: {"Authorization": "Bearer $token"}))
            .body);

    List<SingleArtist> listeArtists = [];

    for (final artist in data["artists"]["items"]) {
      listeArtists.add(SingleArtist.fromJson(artist));
    }

    return listeArtists;
  }
}
