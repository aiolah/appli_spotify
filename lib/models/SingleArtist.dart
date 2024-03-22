class SingleArtist {
  String _id = "";
  String _name = "";
  String _genres = "";
  String _image = "";
  int _followers = 0;

  SingleArtist(
      this._id, this._name, this._genres, this._image, this._followers);

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get genres {
    return _genres;
  }

  String get image {
    return _image;
  }

  int get followers {
    return _followers;
  }

  // Constructeur fromJSON
  factory SingleArtist.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("id") &&
        json.containsKey("name") &&
        json.containsKey("genres") &&
        json.containsKey("images") &&
        json.containsKey("followers")) {
      String genres = "";
      for (var i = 0; i < json["genres"].length; i++) {
        if (i == 0) {
          genres = json["genres"][i];
        } else if (i > 0) {
          genres += ", " + json["genres"][i];
        }
      }

      return SingleArtist(json["id"], json["name"], genres,
          json["images"][0]["url"], json["followers"]["total"]);
    } else {
      throw ArgumentError("Problème lors de l'instanciation de l'objet");
    }
  }
}
