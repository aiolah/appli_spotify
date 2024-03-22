class Album {
  // Attributs
  String _id = "";
  String _name = "";
  String _artist = "";
  String _pochette = "";
  String _releaseDate = "";

  Album(this._id, this._name, this._artist, this._pochette, this._releaseDate);

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get pochette {
    return _pochette;
  }

  // Constructeur fromJSON
  factory Album.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("id") &&
        json.containsKey("name") &&
        json.containsKey("artists") &&
        json.containsKey("images") &&
        json.containsKey("release_date")) {
      return Album(json["id"], json["name"], json["artists"][0]["name"],
          json["images"][0]["url"], json["release_date"]);
    } else {
      throw ArgumentError("Problème lors de l'instanciation de l'objet");
    }
  }

  @override
  String toString() {
    return ("Album $_name de $_artist parut le $_releaseDate");
  }
}
