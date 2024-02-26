import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final db = FirebaseFirestore.instance;

class FirebaseSongQueries {
  FirebaseSongQueries._();

  static void getPlaylistSongs() {}

  void addPlaylist({
    required String userId,
    required String playlistName,
  }) async {
    Map<String, dynamic> playlistData = {
      'count': 0,
      'name': playlistName,
      'songsList': [],
    };

    String playlistId = const Uuid().v4();

    try {
      await db
          .collection('users')
          .doc(userId)
          .collection('playlists')
          .doc(playlistId)
          .set(playlistData);
      debugPrint('Playlist added successfully!');
    } catch (e) {
      debugPrint('Error adding playlist: $e');
    }
  }

  Future<void> addSongToPlaylist({
    required String userId,
    required String playlistId,
    required String song,
  }) async {
    try {
      // Get a reference to the playlist document
      DocumentReference playlistRef = db
          .collection('users')
          .doc(userId)
          .collection('playlists')
          .doc(playlistId);

      // Get the current list of songs
      DocumentSnapshot playlistDoc = await playlistRef.get();
      if (playlistDoc.data != null) {
        List<dynamic> songsList = List.from(playlistDoc.data['songsList']);
      }

      // Add the new song
      songsList.add(song);

      // Update the playlist document with the updated songsList
      await playlistRef.update({'songsList': songsList});

      debugPrint('Song added to playlist successfully!');
    } catch (e) {
      debugPrint('Error adding song to playlist: $e');
    }
  }

  static void removeSongFromPlaylist() {}
}
