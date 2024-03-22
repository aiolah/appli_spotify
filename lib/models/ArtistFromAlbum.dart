class ArtistFromAlbum {
  String _id = "";
  String _name = "";

  ArtistFromAlbum(this._id, this._name);

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  factory ArtistFromAlbum.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("id") && json.containsKey("name")) {
      return ArtistFromAlbum(json["id"], json["name"]);
    } else {
      throw ArgumentError("Problème lors de l'instanciation de l'objet");
    }
  }
}
