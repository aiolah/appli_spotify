class SingleTrack {
  String _id = "";
  String _name = "";
  String _image = "";
  String _previewUrl = "";
  List<String> _artists = [];

  SingleTrack(this._id, this._name, this._image, this._previewUrl, this._artists);

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get image {
    return _image;
  }

  String get previewUrl {
    return _previewUrl;
  }

  List<String> get artists {
    return _artists;
  }

  // Constructeur fromJSON
  factory SingleTrack.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("id") &&
        json.containsKey("name") &&
        json.containsKey("album") &&
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

      return SingleTrack(json["id"], json["name"], json["album"]["images"][0]["url"],
          previewUrl, artists);
    } else {
      throw ArgumentError("Problème lors de l'instanciation de l'objet Track");
    }
  }
}
