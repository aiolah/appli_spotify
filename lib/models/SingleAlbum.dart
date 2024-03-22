import 'TrackFromAlbum.dart';

class SingleAlbum {
  // Attributs
  String _id = "";
  String _name = "";
  String _artist = "";
  String _pochette = "";
  String _releaseDate = "";
  List<TrackFromAlbum> _tracks = [];

  SingleAlbum(this._id, this._name, this._artist, this._pochette,
      this._releaseDate, this._tracks);

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get pochette {
    return _pochette;
  }

  List<TrackFromAlbum> get tracks {
    return _tracks;
  }

  // Constructeur fromJSON
  factory SingleAlbum.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("id") &&
        json.containsKey("name") &&
        json.containsKey("artists") &&
        json.containsKey("images") &&
        json.containsKey("release_date") &&
        json.containsKey("tracks")) {
      List<TrackFromAlbum> tracks = [];
      for (var i = 0; i < json["tracks"].length; i++) {
        tracks.add(TrackFromAlbum.fromJson(json["tracks"]["items"][i]));
      }

      return SingleAlbum(json["id"], json["name"], json["artists"][0]["name"],
          json["images"][0]["url"], json["release_date"], tracks);
    } else {
      throw ArgumentError("Problème lors de l'instanciation de l'objet");
    }
  }

  @override
  String toString() {
    return ("Album $_name de $_artist parut le $_releaseDate");
  }
}
