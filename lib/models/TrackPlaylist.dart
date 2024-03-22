class TrackPlaylist {
  int _id = 0;
  String _name = "";
  String _image = "";
  String _previewUrl = "";
  String _artist = "";

  TrackPlaylist(this._id, this._name, this._image, this._previewUrl, this._artist);

  int get id {
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

  String get artist {
    return _artist;
  }
}
