class TrackFromAlbum {
  bool _play = true;
  String _id = "";
  String _name = "";
  String _previewUrl = "";
  List<String> _artists = [];

  TrackFromAlbum(
      this._play, this._id, this._name, this._previewUrl, this._artists);

  bool get play {
    return _play;
  }

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get previewUrl {
    return _previewUrl;
  }

  List<String> get artists {
    return _artists;
  }

  set play(bool newValue) {
    _play = newValue;
  }

  // Constructeur fromJSON
  factory TrackFromAlbum.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("id") &&
        json.containsKey("name") &&
        json.containsKey("preview_url") &&
        json.containsKey("artists")) {
      List<String> artists = [];
      for (var i = 0; i < json["artists"].length; i++) {
        artists.add(json["artists"][i]["name"]);
      }

      String previewUrl;

      if (json["preview_url"] == null) {
        previewUrl = "";
      } else {
        previewUrl = json["preview_url"];
      }

      return TrackFromAlbum(
          true, json["id"], json["name"], previewUrl, artists);
    } else {
      throw ArgumentError("Problème lors de l'instanciation de l'objet Track");
    }
  }
}
