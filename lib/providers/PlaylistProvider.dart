import 'package:projet_spotify_gorouter/models/TrackPlaylist.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/SingleTrack.dart';

class PlaylistProvider {
  static const _databaseName =
      "MyDatabase.db"; // nom du fichier qui contient la BD
  late Database db; // la base de données en tant qu’objet

  // -- Connexion + création BD
  Future open() async {
    // -- il faut récupérer le dossier dans lequel est stocké le fichier de la BD
    final documentsDirectory = await getDatabasesPath();
    // --- construire le path complet -> ajouter le nom du fichier à la fin
    final path = join(documentsDirectory, _databaseName);
    // --- supprimer la BD déjà existante si besoin
    // await deleteDatabase(path,);
    // --- puis il faut ouvrir la BD
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // la BD n'existe pas, on la crée
      await db.execute('''
  CREATE TABLE playlist_tracks (
  idMusic INTEGER PRIMARY KEY autoincrement,
  name TEXT NOT NULL,
  image TEXT,
  previewUrl TEXT,
  artist TEXT
  )
  ''');

      // await db.execute(
      //     '''ALTER TABLE `playlist_tracks` MODIFY `idMusic` INTEGER NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5; ''');
      // -- éventuellement y ajouter quelques données
      // await db.execute(
      //     "INSERT INTO playlist(marque, modele) VALUES('Renault', 'Clio')");
    });
  }

  Future<List<TrackPlaylist>> getMusics() async {
    List<TrackPlaylist> liste = [];

    List<Map> result = await db.query("playlist_tracks");

    result.forEach((music) {
      liste.add(TrackPlaylist(music["idMusic"], music["name"], music["image"],
          music["previewUrl"], music["artist"]));
    });

    return liste;
  }

  Future<int> addMusic(SingleTrack track, String artist) async {
    var values = {
      "name": track.name,
      "image": track.image,
      "previewUrl": track.previewUrl,
      "artist": artist
    };

    int insertedId = await db.insert("playlist_tracks", values);
    return insertedId;
  }

  Future<int> deleteMusic(int idMusic) async {
    int count = await db
        .rawDelete("DELETE FROM playlist_tracks WHERE idMusic = ?", [idMusic]);
    return count;
  }
}
