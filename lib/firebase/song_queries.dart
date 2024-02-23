import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_player/model/songs_model.dart';
import 'package:uuid/v4.dart';

class FirebaseSongQueries {
  FirebaseSongQueries._();

  static void getPlaylistSongs() {}

  static void addSongToPlaylist(
      {required String userId,
      required String playlistId,
      required Song song}) {
    final db = FirebaseFirestore.instance;
    const playListId = UuidV4();
    db
        .collection("user")
        .doc(userId)
        .collection("playlist")
        .doc(playlistId)
        .set(song.toJson())
        .onError((e, _) => print("Error writing document: $e"));
  }

  static void removeSongFromPlaylist() {}
}
